/* list-model.vala
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

namespace Rpy {
	/**
	 * Specifies the type of a function passed to {@link list_model_foreach}.
	 */
	public delegate bool ForEachFunc<T> (T item, uint index);

	/**
	 * Execute the specified function to each element of ``model``.
	 *
	 * The iteration over the ``model`` can be stopped if the function returns
	 * ``false``.
	 *
	 * @param model The model to iterate over.
	 * @param func The function to execute.
	 * @return ``true`` if the model could be fully iterated, ``false`` if the
	 *         function returned ``false`` at some point.
	 */
	public bool list_model_foreach<T> (ListModel model, ForEachFunc<T> func) requires (typeof (T).is_object ()) {
		var index = 0;
		Object? item = model.get_object (index);

		while (item != null) {
			assert (item.get_type ().is_a (typeof (T)));

			if (!func ((T) item, index)) {
				return false;
			}

			item = model.get_object (++index);
		}

		return true;
	}
}
