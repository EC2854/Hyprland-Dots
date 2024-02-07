import { Widget } from "../../imports.js";
import Brightness from "../../services/brightness.js";
const { Box } = Widget;

const Icon = () =>
	Widget.Label({
		className: "brtIcon",
		setup: (self) => {
			self.hook(Brightness, (self) => {
				const icons = ["󰃚", "󰃛", "󰃜", "󰃝", "󰃞", "󰃟", "󰃠"];

				self.label =
					icons[Math.floor((Brightness.screen * 100) / 14)].toString();
			});
		},
	});

const Slider = () =>
	Widget.Slider({
		className: "brtSlider",
		drawValue: false,
		onChange: ({ value }) => (Brightness.screen = value),
		setup: (self) => {
			self.hook(Brightness, (self) => (self.value = Brightness.screen));
		},
	});

export const BrightnessSlider = () =>
	Box({
		className: "brightnessSlider",
		vertical: true,
		children: [
			Widget.Label({
				className: "brtLabel",
				label: "Brightness",
				hpack: "start",
			}),
			Box({
				children: [Icon(), Slider()],
			}),
		],
	});
