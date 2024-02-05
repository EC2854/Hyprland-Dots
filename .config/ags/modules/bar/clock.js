import { Widget, Utils } from "../../imports.js";
const { execAsync } = Utils;
const { Label, Box } = Widget;

const clock = () => Label({
    setup: (self) => {
        self.poll(1000, (self) =>
            execAsync(["date", "+%a %b %d %H:%M"])
                .then((time) => (self.label = time))
                .catch(console.error),
        );
    },
});

export const Clock = () => Box({
    className: "clock",
    children: [clock()],
});
