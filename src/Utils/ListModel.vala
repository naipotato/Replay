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

namespace Rpy
{
	public delegate bool ForEachFunc<T> (T item, uint index);


	public bool list_model_foreach<T> (GLib.ListModel model, Rpy.ForEachFunc<T> func)
		requires (typeof (T).is_object ())
	{
		var index = 0;
		GLib.Object? item = model.get_object (index);

		while (item != null)
		{
			GLib.return_val_if_fail (((!) item).get_type ().is_a (typeof (T)), false);

			if (!func ((T) item, index))
			{
				return false;
			}

			item = model.get_object (++index);
		}

		return true;
	}
}
