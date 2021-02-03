/* Replay - Explore and watch YouTube videos
 * Copyright 2019 - 2020 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * Replay is free software: you can redistribute it and/or modify it under the
 * terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * Replay is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * Replay.  If not, see <https://www.gnu.org/licenses/>.
 */

public class Rpy.ObservableList<T> : Gee.ArrayList<T>, GLib.ListModel
{
	public ObservableList (T[] array)
	{
		base.wrap (array);
	}


	public override bool add (T item)
	{
		bool added = base.add (item);

		if (added)
		{
			this.items_changed (this.index_of (item), 0, 1);
		}

		return added;
	}

	public new bool add_all (Gee.Collection<T> collection)
	{
		int index = this.size;
		bool added = base.add_all (collection);

		if (added)
		{
			this.items_changed (index, 0, collection.size);
		}

		return added;
	}

	public override void clear ()
	{
		base.clear ();
		this.items_changed (0, this.size, 0);
	}

	public GLib.Object? get_item (uint position)
	{
		if (position >= this.size)
		{
			return null;
		}

		return this[(int) position] as GLib.Object;
	}

	public GLib.Type get_item_type ()
	{
		return typeof (T);
	}

	public uint get_n_items ()
	{
		return this.size;
	}

	public override void insert (int index, T item)
	{
		base.insert (index, item);
		this.items_changed (index, 0, 1);
	}

	public override bool remove (T item)
	{
		int index = this.index_of (item);
		bool removed = base.remove (item);

		if (removed)
		{
			this.items_changed (index, 1, 0);
		}

		return removed;
	}

	public override T remove_at (int index)
	{
		T item = base.remove_at (index);
		this.items_changed (index, 1, 0);
		return item;
	}

	public override void @set (int index, T item)
	{
		base[index] = item;
		this.items_changed (index, 1, 1);
	}
}
