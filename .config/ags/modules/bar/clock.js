// import { Widget, Utils } from "../../imports.js";
const { execAsync } = Utils;

export const Clock = () => Widget.Button({
    className: "clock",
    setup: (self) => {
        self.poll(1000, (self) =>
            execAsync(["date", "+%a %b %d %H:%M"])
                .then((time) => (self.label = time))
                .catch(console.error),
        );
    },
});
