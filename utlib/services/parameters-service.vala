/* UTLib - A YouTube Data API client library for Vala
 * Copyright (C) 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * UTLib is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * UTLib is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with UTLib.  If not, see <https://www.gnu.org/licenses/>.
 */

public class Utlib.ParametersService : Object {

  private Gee.Map<string, Utlib.Parameter> _parameters;

  public Request request { get; construct; }

  public ParametersService (Request req) {
    Object (
      request: req
    );
  }

  construct {
    this._parameters = new Gee.HashMap<string, Utlib.Parameter> ();
  }

  public new Utlib.Parameter @get (string prop_name) {
    return this._parameters[prop_name];
  }

  public new void @set (string prop_name, Utlib.Parameter param) {
    this._parameters[prop_name] = param;
  }

  public string? parse_parameters () throws Utlib.ParserError {
    var parsed_parameters = new Gee.ArrayList<string> ();

    foreach (var item in this._parameters.entries) {
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

    string? param_value = null;

    if (spec.value_type.is_a (Type.BOOLEAN)) {
      debug (@"$prop_name is a boolean");
      bool @value;
      this.request.@get (prop_name, out @value);
      param_value = should_ignore (spec, @value) ? null : @value.to_string ();
    } else if (spec.value_type.is_a (Type.INT)) {
      debug (@"$prop_name is an integer");
      int @value;
      this.request.@get (prop_name, out @value);
      param_value = should_ignore (spec, @value) ? null : @value.to_string ();
    } else if (spec.value_type.is_a (Type.STRING)) {
      debug (@"$prop_name is a string");
      this.request.@get (prop_name, out param_value);
    } else if (spec.value_type.is_enum ()) {
      debug (@"$prop_name is an enum");
      int @value;
      this.request.@get (prop_name, out @value);
      param_value = should_ignore (spec, @value) ? null :
        EnumUtils.to_string (spec.value_type, @value);
    } else {
      throw new Utlib.ParserError.TYPE_NOT_SUPPORTED (
        @"$prop_name is a $(spec.value_type.name ()) and it is not supported"
      );
    }

    if (param.is_required && param_value == null) {
      throw new Utlib.ParserError.REQUIRED_PARAM_NOT_SET (
        @"$(param.name) is required but it is not setted and has no default value"
      );
    }

    return param_value == null ? null : @"$(param.name)=$param_value";
  }

  private bool should_ignore<T> (ParamSpec spec, T @value) {
    Value val = spec.get_default_value ();

    if (spec.value_type.is_a (Type.BOOLEAN)) {
      return val.get_boolean () == (bool) @value;
    } else if (spec.value_type.is_a (Type.INT)) {
      return val.get_int () == (int) @value;
    } else if (spec.value_type.is_enum ()) {
      return val.get_enum () == (int) @value;
    } else {
      return false;
    }
  }
}
