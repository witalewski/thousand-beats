module Counter = %styled.span(`
  display: flex;
  align-items: center;
  justify-content: center;
  flex-basis: 33%;
`)

@react.component
let make = (~timeRemainingRatio) => {
  let unitsRemaining = (timeRemainingRatio *. 1000.)->Js.Math.floor
  <Counter> {unitsRemaining->Belt.Int.toString->React.string} </Counter>
}
