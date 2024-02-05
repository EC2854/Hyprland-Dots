import { Widget, Hyprland } from "../../imports.js";
const { Box } = Widget;

const ClientTitle = () => Widget.Label({
    label: Hyprland.active.client.bind('title').transform(title => {
        const maxCharacters = 40;
        if (title.length > maxCharacters) {
            return title.substring(0, maxCharacters) + '...';
        } else {
            return title;
        }
    }),
});
export const Title = () => Box({
    className: 'title',
    children: [ClientTitle()],
});
