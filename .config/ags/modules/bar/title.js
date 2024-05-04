// import { Widget, Hyprland, Utils } from "../../imports.js";
const Hyprland = await Service.import("hyprland");
const { execAsync } = Utils;

export const Title = () => Widget.Button({
    className: 'title',
    visible:Hyprland.active.client.bind('title').transform(title => title.length > 0),
    label: Hyprland.active.client.bind('title').transform(title => title.length > 40 ? title.substring(0, 40) + '...' : title),
    onClicked: () => {
        execAsync(['bash', '-c', 'hyprctl dispatch killactive', '&']);
    },
});
