import { Widget } from "../../../imports.js";
import { Audio } from "../../../imports.js";
const { Box } = Widget;

const volume = () => Box({
    children: [
        Widget.Icon().hook(Audio, self => {
            if (!Audio.speaker)
                return;

            const category = {
                101: 'overamplified',
                67: 'high',
                34: 'medium',
                1: 'low',
                0: 'muted',
            };

            const icon = Audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
                threshold => threshold <= Audio.speaker.volume * 100);

            self.icon = `audio-volume-${category[icon]}-symbolic`;
        }, 'speaker-changed'),
    ],
});

export const Volume = () => Box({
    class_name: 'volume',
    children: [volume()],
});
