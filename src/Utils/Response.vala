/*
 * Copyright 2022 Nahuel Gomez https://nahuelwexd.com
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

sealed class Rpy.Response {
    private InputStream _input_stream;

    public uint   status_code { get; set; }
    public string status_text { get; set; }
    public bool   ok          { get; set; }

    public Response (InputStream input_stream) {
        this._input_stream = input_stream;
    }

    public async Bytes bytes () throws Error {
        var output_stream = new MemoryOutputStream.resizable ();
        var input_stream = this._input_stream;

        // We take the contents of the input stream, and move them to a
        // memory-based output stream, so that we can get the bytes from it in
        // a simple manner
        yield output_stream.splice_async (input_stream, CLOSE_SOURCE | CLOSE_TARGET);

        return output_stream.steal_as_bytes ();
    }

    public async string text () throws Error {
        var bytes = yield this.bytes ();
        var data = Bytes.unref_to_data ((owned) bytes);

        var raw_text = (string) data;
        var raw_text_length = data.length;
        //  ^ necessary because we're not sure if the string ends with null, and
        // the length property of string is nothing more than a call to strlen()

        if (raw_text.validate (raw_text_length))
            return raw_text;

        return raw_text.make_valid (raw_text_length);
    }

    public async GJson.Node json () throws Error {
        var text = yield this.text ();
        return GJson.Node.parse (text);
    }
}
