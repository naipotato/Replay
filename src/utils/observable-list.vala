/* observable-list.vala
 *
 * Copyright 2021 Nahuel Gomez Castro <nahual_gomca@outlook.com.ar>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

/**
 * A list that notifies its modifications.
 */
public class Rpy.ObservableList<T> : Gee.ArrayList<T>, ListModel {
	/**
	 * Create a new list from an array of elements.
	 */
	public ObservableList.wrap (T[] array) {
		base.wrap (array);
	}

	protected override bool add (T item) {
		bool added = base.add (item);

		if (added) {
			this.items_changed (this.index_of (item), 0, 1);
		}

		return added;
	}

	/**
	 * Add all elements of the specified collection.
	 *
	 * Changes will only be notified after all elements have been added.
	 */
	public new bool add_all (Gee.Collection<T> collection) {
		int index = this.size;
		bool added = base.add_all (collection);

		if (added) {
			this.items_changed (index, 0, collection.size);
		}

		return added;
	}

	protected override void clear () {
		base.clear ();
		this.items_changed (0, this.size, 0);
	}

	protected Object? get_item (uint position) {
		if (position >= this.size) {
			return null;
		}

		return this[(int) position] as Object;
	}

	protected Type get_item_type () {
		return typeof (T);
	}

	protected uint get_n_items () {
		return this.size;
	}

	protected override void insert (int index, T item) {
		base.insert (index, item);
		this.items_changed (index, 0, 1);
	}

	protected override bool remove (T item) {
		int index = this.index_of (item);
		bool removed = base.remove (item);

		if (removed) {
			this.items_changed (index, 1, 0);
		}

		return removed;
	}

	protected override T remove_at (int index) {
		T item = base.remove_at (index);
		this.items_changed (index, 1, 0);
		return item;
	}

	protected override void @set (int index, T item) {
		base[index] = item;
		this.items_changed (index, 1, 1);
	}
}
