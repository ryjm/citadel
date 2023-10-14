#!/usr/bin/env bash
usage() {
  printf "Usage: $0 [-w] [-g] URBIT_DESK_DIRECTORY -d [DEPENDENCY1_DIRECTORY] -d [DEPENDENCY2_DIRECTORY] ...\n(-w: flag to watch and live copy code)\n(-g: install built ui to globber desk)\n" 1>&2
  exit 1
}

if [ $# -eq 0 ]; then
  usage
  exit 2
fi

while getopts "wgd:" opt; do
  case $opt in
  w)
    WATCH_MODE="true"
    ;;
  g)
    GLOBBER="true"
    ;;
  d)
    echo "adding dependency: $OPTARG"
    dependencies+=("$OPTARG")
    ;;
  *)
    usage
    ;;
  esac
done
DESK_DIR=$piers/$pier/$project
PIER=$(dirname $DESK_DIR)
DESK=$(basename $DESK_DIR)

port=$(cat $PIER/.http.ports | grep loopback | tr -s ' ' '\n' | head -n 1)
lensd() {
  curl -s \
    --data "{\"source\":{\"dojo\":\"$1\"},\"sink\":{\"stdout\":null}}" \
    "http://localhost:$port" | xargs printf %s | sed 's/\\n/\n/g'
}

lensa() {
  curl -s \
    --data "{\"source\":{\"dojo\":\"$2\"},\"sink\":{\"app\":\"$1\"}}" \
    "http://localhost:$port" | xargs printf %s | sed 's/\\n/\n/g'
}

sync() {
  echo "dependencies: ${dependencies[@]}"

  for dep in ${dependencies[@]}; do
    echo "installing dependency: $dep"
    if [ ! -d "$dep" ]; then
      echo "dependency $dep does not exist"
      exit 1
    fi
    rsync -r --copy-links --exclude-from=${exclude} "$dep/" $DESK_DIR/
  done
  # rsync -r --copy-links --exclude-from=${exclude} $desk/* $DESK_DIR/
  if [ "$GLOBBER" ]; then
    rsync -r --copy-links $dist/* $DESK_DIR/$project
  fi
  copy $pier || rsync -r --copy-links --exclude-from=${exclude} $desk/* $DESK_DIR/
}
if [ ! -d "$DESK_DIR" ]; then
  echo "Creating new desk: $project"
  lensa 'hood' "+hood/new-desk %$project"
  sleep 1
  lensa 'hood' "+hood/mount %$project"
  sleep 1
fi

if [ -z "$WATCH_MODE" ]; then
  echo "Installing $project to $DESK_DIR"
  rm -r $DESK_DIR/*
  sync
  echo "Installed $project to $DESK_DIR"
  lensa 'hood' "+hood/commit %$project"
  if [ "$GLOBBER" ]; then
    sleep 1
    lensd "-garden!make-glob %globber /$project"
    GLOBS=$PIER/.urb/put
    GLOB=$(ls -t $GLOBS | head -1)
    TARGET_GLOBS=./globs/
    mkdir -p $TARGET_GLOBS
    cp "$GLOBS/$GLOB" $TARGET_GLOBS/
    echo "copied from $GLOBS to $TARGET_GLOBS"
    HASH=$(basename $GLOB | sed 's/^glob-//;s/\.glob$//')
    echo "glob hash: $HASH"
  fi
else
  echo "Watching for changes to copy to $DESK_DIR..."
  rm -r $DESK_DIR/*
  while [ 0 ]; do
    sleep 0.8
    sync
  done
fi
