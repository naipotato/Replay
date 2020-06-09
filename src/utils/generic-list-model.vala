/* Replay - An open source YouTube client for GNOME
 * Copyright (C) 2019 - 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * Replay is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Replay is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Replay.  If not, see <https://www.gnu.org/licenses/>.
 */

using Gee;

namespace Replay.Utils {

    public class GenericListModel<T> : AbstractList<T>, ListModel {

        private Gee.List<T> _data;

        public override bool read_only {
            get {
                return _data.read_only;
            }
        }

        public override int size {
            get {
                return _data.size;
            }
        }

        public GenericListModel () {
            _data = new ArrayList<T> ();
        }

        public GenericListModel.from_list (Gee.List<T> data) {
            _data = data;
        }

        public override bool add (T item) {
            var added = _data.add (item);

            if (added) {
                items_changed (_data.index_of (item), 0, 1);
            }

            return added;
        }

        public override void clear () {
            _data.clear ();
            items_changed (0, _data.size, 0);
        }

        public override bool contains (T item) {
            return item in _data;
        }

        public override T @get (int index)
            requires (index >= 0)
            requires (index < _data.size)
        {
            return _data[index];
        }

        public Object? get_item (uint position)
            requires (position >= 0)
            requires (position < _data.size)
        {
            return _data[(int) position] as Object;
        }

        public Type get_item_type () {
            return typeof (T);
        }

        public uint get_n_items () {
            return _data.size;
        }

        public override int index_of (T item) {
            return _data.index_of (item);
        }

        public override void insert (int index, T item)
            requires (index >= 0)
            requires (index < _data.size)
        {
            _data.insert (index, item);
            items_changed (index, 0, 1);
        }

        public override Iterator<T> iterator () {
            return _data.iterator ();
        }

        public override ListIterator<T> list_iterator () {
            return _data.list_iterator ();
        }

        public override bool remove (T item) {
            var removed = _data.remove (item);

            if (removed) {
                items_changed (_data.index_of (item), 1, 0);
            }

            return removed;
        }

        public override T remove_at (int index)
            requires (index >= 0)
            requires (index < _data.size)
        {
            var item_removed = _data.remove_at (index);
            items_changed (index, 1, 0);
            return item_removed;
        }

        public override void @set (int index, T item)
            requires (index >= 0)
            requires (index < _data.size)
        {
            _data[index] = item;
            items_changed (index, 1, 1);
        }

        public override Gee.List<T>? slice (int start, int stop) {
            return _data[start:stop];
        }
    }
}
