module Controls = %styled.div(`
  display: flex;
  align-items: center;
  justify-content: center;
  flex-basis: 33%;
`)

let buttonStyle = ReactDOM.Style.make(
  ~width="26px",
  ~border="none",
  ~background="none",
  ~color="#ebbcba",
  (),
)

@react.component
let make = (~onToggle, ~resetTimer, ~labelHtml: string) => {
  <Controls>
    <button
      style={buttonStyle} dangerouslySetInnerHTML={{"__html": labelHtml}} onClick={_ => onToggle()}
    />
    <button
      style={buttonStyle} dangerouslySetInnerHTML={{"__html": "&#8634;"}} onClick={_ => resetTimer()}
    />
  </Controls>
}
