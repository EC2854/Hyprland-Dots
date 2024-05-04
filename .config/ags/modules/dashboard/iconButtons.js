const { execAsync } = Utils;

export const PowerIcon = () => Widget.Button({
    className: 'Icon',
    child: Widget.Label({ label:"⏻" }),
    onClicked: () => {
        App.closeWindow('dashboard');
        execAsync(['bash', '-c', '~/.config/hypr/scripts/powermenu.sh', '&']);
    },
})
export const TerminalIcon = () => Widget.Button({
    className: 'Icon',
    child: Widget.Label({ label:"󰄛" }),
    onClicked: () => {
        execAsync(['bash', '-c', 'kitty', '&']);
        App.closeWindow('dashboard');
    },

})
