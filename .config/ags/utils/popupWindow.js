export default ({
  onOpen = () => {},
  onClose = () => {},

  name,
  child,
  transition = "slide_up",
  transitionDuration = 250,
  ...props
}) => {
  const window = Widget.Window({
    name,
    visible: false,
    ...props,

    child: Widget.Box({
      css: `min-height: 2px;
            min-width: 2px;`,
      child: Widget.Revealer({
        transition,
        transitionDuration,
        hexpand: true,
        vexpand: true,
        child: child || Widget.Box(),
        setup: (self) => {
          self.hook(App, (rev, currentName, isOpen) => {
            if (currentName === name) {
              rev.revealChild = isOpen;

              if (isOpen) {
                onOpen(window);
              } else {
                Utils.timeout(transitionDuration, () => {
                  onClose(window);
                });
              }
            }
          });
        },
      }),
    }),
  });
  window.getChild = () => window.child.children[0].child;
  window.setChild = (newChild) => {
    window.child.children[0].child = newChild;
    window.child.children[0].show_all();
  };

  return window;
};
