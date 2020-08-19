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

public class Utils.GenericListModel<T> : Gee.AbstractList<T>, ListModel {

  private Gee.List<T> _data;

  public override bool read_only {
    get {
      return this._data.read_only;
    }
  }

  public override int size {
    get {
      return this._data.size;
    }
  }

  public GenericListModel () {
    this._data = new Gee.ArrayList<T> ();
  }

  public GenericListModel.from_list (Gee.List<T> data) {
    this._data = data;
  }

  public override bool add (T item) {
    var added = this._data.add (item);

    if (added) {
      this.items_changed (this.index_of (item), 0, 1);
    }

    return added;
  }

  public bool add_all (Gee.Collection<T> collection) {
    foreach (var item in collection) {
      if (!this.add (item)) {
        return false;
      }
    }

    return true;
  }

  public override void clear () {
    this._data.clear ();
    items_changed (0, this._data.size, 0);
  }

  public override bool contains (T item) {
    return item in this._data;
  }

  public override T @get (int index)
    requires (index >= 0)
    requires (index < this._data.size)
  {
    return this._data[index];
  }

  public Object? get_item (uint position)
    requires (position >= 0)
    requires (position < this._data.size)
  {
    return this._data[(int) position] as Object;
  }

  public Type get_item_type () {
    return typeof (T);
  }

  public uint get_n_items () {
    return this._data.size;
  }

  public override int index_of (T item) {
    return this._data.index_of (item);
  }

  public override void insert (int index, T item)
    requires (index >= 0)
    requires (index < this._data.size)
  {
    this._data.insert (index, item);
    this.items_changed (index, 0, 1);
  }

  public override Gee.Iterator<T> iterator () {
    return this._data.iterator ();
  }

  public override Gee.ListIterator<T> list_iterator () {
    return this._data.list_iterator ();
  }

  public override bool remove (T item) {
    var removed = this._data.remove (item);

    if (removed) {
      this.items_changed (this._data.index_of (item), 1, 0);
    }

    return removed;
  }

  public override T remove_at (int index)
    requires (index >= 0)
    requires (index < this._data.size)
  {
    var item_removed = this._data.remove_at (index);
    this.items_changed (index, 1, 0);
    return item_removed;
  }

  public override void @set (int index, T item)
    requires (index >= 0)
    requires (index < this._data.size)
  {
    this._data[index] = item;
    this.items_changed (index, 1, 1);
  }

  public override Gee.List<T>? slice (int start, int stop) {
    return this._data[start:stop];
  }
}
