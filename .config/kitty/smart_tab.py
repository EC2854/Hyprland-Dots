import kitty.key_encoding as ke
from kitty.options.utils import parse_key_action


def main(args):
    pass


def handle_result(args, answer, target_window_id, boss):
    _kitten = args[0]
    action_if_tabs = ' '.join(args[1:-1])
    if_no_tabs = args[-1]

    tm = boss.active_tab_manager
    if tm is None:
        return

    if len(tm.tabs) > 1:
        boss.dispatch_action(parse_key_action(action_if_tabs))
        return

    w = boss.window_id_map.get(target_window_id)
    mods, key = ke.parse_shortcut(if_no_tabs)
    shift, alt, ctrl, super, hyper, meta, caps_lock, num_lock = (
        bool(mods & bit) for bit in (
           ke.SHIFT, ke.ALT, ke.CTRL, ke.SUPER,
           ke.HYPER, ke.META, ke.CAPS_LOCK, ke.NUM_LOCK))
    for action in [ke.PRESS, ke.RELEASE]:
        key_event = ke.KeyEvent(
            type=action, mods=mods, key=key,
            shift=shift, alt=alt, ctrl=ctrl, super=super,
            hyper=hyper, meta=meta, caps_lock=caps_lock, num_lock=num_lock)
        window_system_event = key_event.as_window_system_event()
        sequence = w.encoded_key(window_system_event)
        w.write_to_child(sequence)


handle_result.no_ui = True
