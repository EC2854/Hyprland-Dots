import { Widget, Hyprland, Utils } from "../../imports.js";
const { execAsync } = Utils;
const { Box } = Widget;

const ClientTitle = () => Widget.Button({
    className: 'title',
    label: Hyprland.active.client.bind('title').transform(title => {
        const maxCharacters = 40;
        if (title.length > maxCharacters) {
            return title.substring(0, maxCharacters) + '...';
        } else {
            return title;
        }
    }),
    onClicked: () => {
        execAsync(['bash', '-c', 'hyprctl dispatch killactive', '&']);
    },
});
export const Title = () => Box({
    children: [ClientTitle()],
});
