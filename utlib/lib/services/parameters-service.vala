/* UTLib - Yet another wrapper to the YouTube Data API v3.
 * Copyright (C) 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * This library is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

public class Utlib.ParametersService : Object {

    private Gee.Map<string, Utlib.Parameter> parameters;

    public Request request { get; construct; }

    public ParametersService (Request req) {
        Object (
            request: req
        );
    }

    construct {
        this.parameters = new Gee.HashMap<string, Utlib.Parameter> ();
    }

    public new Utlib.Parameter @get (string prop_name) {
        return this.parameters[prop_name];
    }

    public new void @set (string prop_name, Utlib.Parameter param) {
        this.parameters[prop_name] = param;
    }

    public string? parse_parameters () throws Utlib.ParserError {
        var parsed_parameters = new Gee.ArrayList<string> ();

        foreach (var item in this.parameters.entries) {
            var parsed_parameter = this.parse_parameter (item.key, item.value);
            if (parsed_parameter == null) {
                debug (@"$(item.value.name) not parsed");
                continue;
            }

            parsed_parameters.add (parsed_parameter);
            debug (@"$parsed_parameter added");
        }

        return string.joinv ("&", parsed_parameters.to_array ());
    }

    private string? parse_parameter (string prop_name, Utlib.Parameter param) throws Utlib.ParserError {
        var klass = (ObjectClass) this.request.get_type ().class_ref ();
        var spec = klass.find_property (prop_name);

        if (spec == null) {
            throw new Utlib.ParserError.PROPERTY_NOT_FOUND (
                @"$(klass.get_name ()) has no $prop_name property"
            );
        }

        string param_value = "";

        switch (spec.value_type) {
            case Type.STRING:
                debug (@"$prop_name is string");

                Value? val = Value (spec.value_type);
                this.request.get_property (prop_name, ref val);

                param_value = val.get_string ();

                if (param_value == null) {
                    debug (@"$prop_name is string");
                    param_value = "";
                }

                break;
            default:
                break;
        }

        if (param.is_required && param_value == "") {
            debug (@"$(param.name) is required and is not setted");

            if (param.default_value == "") {
                throw new Utlib.ParserError.REQUIRED_PARAM_NOT_SET (
                    @"$(param.name) is required but it is not setted and has no default value"
                );
            } else {
                param_value = param.default_value;
            }
        }

        return param_value == "" ? null : @"$(param.name)=$param_value";
    }
}
