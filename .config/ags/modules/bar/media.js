// import { Widget, Utils, Mpris } from "../../imports.js";
const Mpris = await Service.import("mpris");
const { execAsync } = Utils;

export const Media = () => Widget.Button({
    class_name: 'media',
    on_primary_click: () => Mpris.getPlayer('').playPause(),
    onSecondaryClickRelease: () => {
        execAsync(['bash', '-c', 'anyrun', '&']);
    },
    on_scroll_up: () => Mpris.getPlayer('').next(),
    on_scroll_down: () => Mpris.getPlayer('').previous(),
    child: Widget.Label('-').hook(Mpris, self => {
        if (Mpris.players[0]) {
            const { track_title } = Mpris.players[0];
            self.label = track_title.length > 60 ? `${track_title.substring(0, 60)}...` : track_title;
        } else {
            self.label = 'Nothing is playing';
        }
    }, 'player-changed'),
});

