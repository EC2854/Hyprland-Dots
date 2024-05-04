const Audio = await Service.import("audio");
const { Box } = Widget;

const Icon = () => Widget.Label({
    className: "sldIcon",
    setup: (self) => {
        self.hook(
            Audio,
            (self) => {
                if (!Audio.speaker) return;

                const icons = ["󰝟", "󰕿", "󰖀", "󰕾"];

                self.label =
                icons[
                Audio.speaker.stream.isMuted
                ? 0
                : Math.floor((Audio.speaker.volume * 100) / 26)
                ].toString();
            },
            "speaker-changed",
        );
    },
});

const Slider = () => Widget.Slider({
    className: "sldSlider",
    drawValue: false,
    onChange: ({ value }) => (Audio.speaker.volume = value),
    setup: (self) => {
      self.hook(
        Audio,
        (self) => {
          if (!Audio.speaker) return;

          self.value = Audio.speaker.volume;
        },
        "speaker-changed",
      );
    },
  });

export const VolumeSlider = () => Box({
    className: "Slider",
    vertical: true,
    children: [
        Widget.Label({
            className: "sldLabel",
            label: "Volume",
            hpack: "start",
        }),
        Box({
            children: [
                Icon(), 
                Slider()
            ],

        }),
    ],
});
