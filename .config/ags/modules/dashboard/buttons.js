import { PowerIcon, TerminalIcon } from "./iconButtons.js"
const Network = await Service.import("network");
const Bluetooth = await Service.import("bluetooth");
const { execAsync } = Utils
const { Box } = Widget;

const uptime = Box({
    children: [
        Widget.Label({
            setup: (self) => self
                .poll(5000, label => {
                    execAsync(['bash', '-c', `w | sed -n '1p' | cut -d, -f1 | cut -d' ' -f4-`]) 
                        .then(upTimeString => {
                            label.label = `Uptime: ${upTimeString}`;
                        }).catch(print);
                })
            ,
        }),
        Box({ hexpand: true }),
        TerminalIcon({ hpack: 'end' }),
        PowerIcon({ hpack: 'end' }),
    ]
});

const BluetoothButton = () => Widget.Button({
    onClicked: () => Bluetooth.toggle(),
    onSecondaryClickRelease: () => {
        execAsync(['bash', '-c', 'blueman-manager', '&']);
        App.closeWindow('dashboard');
    },
    child: Box({
        className: "fullbutton",
        vpack: "center",
        vexpand: true,
        setup: (self) => {
            self.hook(Bluetooth, (self) => {
                if (Bluetooth.enabled) {
                    self.toggleClassName("off", false);
                } else {
                    self.toggleClassName("off", true);
                }
            });
        },
        children: [
            Widget.Label({
                className: "fullbuttonIcon",
                label: "󰂲",
                setup: (self) => {
                    self.hook(Bluetooth, (self) => {
                        if (Bluetooth.enabled) {
                            self.label = "󰂯";
                        } else {
                            self.label = "󰂲";
                        }
                    });
                },
            }),
            Widget.Label({
                label: "Bluetooth",
            })
        ],
    }),
});
const WifiButton = () => Widget.Button({
    onClicked: () => Network.toggleWifi(),
    onSecondaryClickRelease: () => {
        execAsync(['bash', '-c', 'XDG_CURRENT_DESKTOP="gnome" gnome-control-center wifi', '&']);
        App.closeWindow('dashboard');
    },
    child: Box({
        className: "fullbutton",
        vpack: "center",
        vexpand: true,
        setup: (self) => {
            self.hook(Network, (self) => {
                if (Network.wifi.internet === "disconnected") {
                    self.toggleClassName("off", true);
                } else {
                    self.toggleClassName("off", false);
                }
            });
        },
        children: [
            Widget.Label({
                className: "fullbuttonIcon",
                label: "󰤭",
                setup: (self) => {
                    self.hook(Network, (self) => {
                        if (Network.wifi.internet === "disconnected") {
                            self.label = "󰤭";
                        } else {
                            self.label = "󰤨";
                        }
                    });
                },
            }),
            Widget.Label({
                label: " Wifi",
            })
        ],
    }),
});
export const Buttons = () => Box({
    className: "quicktoggles",
    vertical: true,
    vexpand: false,
    children: [
        uptime,
        Box({
            className: "buttons",
            children: [
                WifiButton(),
                BluetoothButton(),
            ]
        }),
    ]   
})
