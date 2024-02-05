import Mpris from 'resource:///com/github/Aylur/ags/service/mpris.js';
import { Widget } from "../../imports.js";
const { Box } = Widget;

const media = () => Widget.Button({
    class_name: 'media',
    on_primary_click: () => Mpris.getPlayer('')?.playPause(),
    on_scroll_up: () => Mpris.getPlayer('')?.next(),
    on_scroll_down: () => Mpris.getPlayer('')?.previous(),
    child: Widget.Label('-').hook(Mpris, self => {
        if (Mpris.players[0]) {
            const { track_title } = Mpris.players[0];
            self.label = `${track_title}`;
        } else {
            self.label = 'Nothing is playing';
        }
    }, 'player-changed'),
});


export const Media = () => Box({
    children: [media()],
});
