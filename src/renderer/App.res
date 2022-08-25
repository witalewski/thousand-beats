%%raw(`
  import setBackgroundPhoto from './setBackgroundPhoto.js';
  setBackgroundPhoto();
`)

%styled.global(`
  html, body {
    margin: 0;
    padding: 0;
    user-select: none;
  }
`)

module App = %styled.div(`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-family: "Lato";
  width: 100px;
  height: 100px;
  border-radius: 50%;
  overflow: hidden;
  background-color: #303030;
  background-blend-mode: overlay;
  background-size: cover;
  color: #f6c177;
`)

module Spacer = %styled.div(`
  flex-basis: 33%;
`)

let workingTimePerHour = 5 * 60 * 60 * 1000 / 7
// let workingTimePerHour = 10000

let playSign = "&#9658;"
let pauseSign = "||"

let initializeIntervalState: unit => option<Js.Global.intervalId> = _ => None

let intervalLastRunAt: ref<option<int>> = ref(None)

@react.component
let make = _ => {
  let (intervalId, setIntervalId) = React.useState(initializeIntervalState)
  let (timeRemaining, setTimeRemaining) = React.useState(_ => workingTimePerHour)
  let (startButtonLabel, setStartButtonLabel) = React.useState(_ => playSign)

  let runInterval = _ => {
    let now = Js.Date.now()->Belt.Float.toInt
    let timeToSubtract = switch intervalLastRunAt.contents {
    | None => 100
    | Some(x) => now - x
    }
    setTimeRemaining(timeRemaining => timeRemaining - timeToSubtract)
    intervalLastRunAt.contents = Some(now)
  }

  let startTimer = _ => {
    setIntervalId(_ => Some(Js.Global.setInterval(runInterval, 100)))
    setStartButtonLabel(_ => pauseSign)
  }

  let pauseTimer = id => {
    Js.Global.clearInterval(id)
    setIntervalId(_ => None)
    setStartButtonLabel(_ => playSign)
    intervalLastRunAt.contents = None
  }

  let resetTimer = _ => {
    let _ = Belt.Option.forEach(intervalId, id => pauseTimer(id))
    setTimeRemaining(_ => workingTimePerHour)
  }

  let onToggle = _ => {
    switch intervalId {
    | None => startTimer()
    | Some(id) => pauseTimer(id)
    }
  }

  React.useEffect1(_ => {
    if timeRemaining < 0 {
      resetTimer()
    }
    None
  }, [timeRemaining])

  let timeRemainingRatio = timeRemaining->Belt.Int.toFloat /. workingTimePerHour->Belt.Int.toFloat

  <App className="app">
    <Spacer />
    <Counter timeRemainingRatio />
    <Controls onToggle resetTimer labelHtml={startButtonLabel} />
    <Chime timeRemaining />
  </App>
}
