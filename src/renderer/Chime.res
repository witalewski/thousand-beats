@send external play: Dom.element => unit = "play"

@react.component
let make = (~timeRemaining) => {
  let audioRef = React.useRef(Js.Nullable.null)

  React.useEffect1(_ => {
    if timeRemaining < 0 {
      audioRef.current->Js.Nullable.toOption->Belt.Option.forEach(audio => audio->play)
    }
    None
  }, [timeRemaining])

  <audio
    ref={ReactDOM.Ref.domRef(audioRef)}
    src="https://cdn.pixabay.com/audio/2021/08/09/audio_0af6cbd186.mp3"
  />
}
