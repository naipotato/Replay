namespace Unitube {

    public enum ElementTheme {
        SYSTEM, LIGHT, DARK;

        public static bool try_parse_nick (string nick, out ElementTheme result = null) {
            // Based on example provided by Valadoc on
            // https://valadoc.org/gobject-2.0/GLib.EnumValue.html

            EnumClass enumc = (EnumClass) typeof (ElementTheme).class_ref ();

            unowned EnumValue? eval = enumc.get_value_by_nick (nick);
            if (eval == null) {
                result = ElementTheme.SYSTEM;
                return false;
            }

            result = (ElementTheme) eval.value;
            return true;
        }

        public string to_nick () {
            // Based on example provided by Valadoc on
            // https://valadoc.org/gobject-2.0/GLib.EnumValue.html

            EnumClass enumc = (EnumClass) typeof (ElementTheme).class_ref ();
            unowned EnumValue? eval = enumc.get_value (this);
            return_val_if_fail (eval != null, null);
            return eval.value_nick;
        }
    }
}
