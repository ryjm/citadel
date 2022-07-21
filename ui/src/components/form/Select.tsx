
interface SelectProps extends React.SelectHTMLAttributes<HTMLSelectElement> {
  innerRef?: any
}

export const Select = ({ innerRef, ...props }: SelectProps) => {
  const selectStyle = {
    padding: '4px 8px'
  }

  return <select ref={innerRef} {...props} style={{ ...selectStyle, ...props.style }} />
}
