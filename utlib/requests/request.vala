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

public abstract class Utlib.Request<T> : Object {

  public Utlib.Client client { get; construct; }
  protected Utlib.ParametersService params_service { get; set; }

  public string? access_token { get; set; }
  public string? callback { get; set; }
  public string? fields { get; set; }
  public string? key { get; set; }
  public bool pretty_print { get; set; default = true; }
  public string? quota_user { get; set; }
  public string? user_ip { get; set; }

  protected abstract string url { get; }


  protected Request (Utlib.Client client) {
    Object (
      client: client
    );
  }

  construct {
    this.client.bind_property ("api-key", this, "key",
      BindingFlags.DEFAULT | BindingFlags.SYNC_CREATE);
  }

  /**
    * Execute this request.
    *
    * @return The parsed response of this request.
    */
  public virtual async T execute () throws Utlib.RequestError, Utlib.ParserError, Error {
    // Parse all the parameters in the request
    var parameters = this.params_service.parse_parameters ();
    var uri = @"$(this.url)?$(parameters)";

    debug (@"The parsed url is: $uri");

    // Get the session for the current client instance and create a new message
    var session = this.client.session;
    var message = new Soup.Message ("GET", uri);

    // Send the message asynchronously and grab the InputStream as a DataInputStream in order to
    // read it
    var istream = yield session.send_async (message);
    var distream = new DataInputStream (istream);

    // Create a new StringBuilder to save the response body
    var builder = new StringBuilder ();

    // Read it
    string line;
    while ((line = yield distream.read_line_async ()) != null) {
      builder.append (line);
    }

    var parsed_object = yield GJson.Object.parse_async (builder.str);

    if (message.status_code == Soup.Status.OK) {
      return (T) GJson.deserialize_object (typeof (T), parsed_object);
    } else {
      throw new Utlib.RequestError.SERVER_ERROR (
        parsed_object.get_object_member ("error").get_string_member ("message")
      );
    }
  }

  protected virtual void init_parameters () {
    if (params_service == null) {
      debug ("params_service is null. Creating new instance.");
      params_service = new Utlib.ParametersService (this);
    }

    this.params_service["access-token"] = new Utlib.Parameter ("access_token");
    this.params_service["callback"] = new Utlib.Parameter ("callback");
    this.params_service["fields"] = new Utlib.Parameter ("fields");
    this.params_service["key"] = new Utlib.Parameter ("key");
    this.params_service["pretty-print"] = new Utlib.Parameter ("prettyPrint");
    this.params_service["quota-user"] = new Utlib.Parameter ("quotaUser");
    this.params_service["user-ip"] = new Utlib.Parameter ("userIp");
  }
}
