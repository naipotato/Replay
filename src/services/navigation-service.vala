/* navigation-service.vala
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
 * A service in charge of managing the navigation of the app.
 *
 * Stores a page map associated with a key to be able to refer to them more
 * easily.
 *
 * It also notifies the navigation events, useful for the implementation of
 * widgets that show the current page.
 */
public class Rpy.NavigationService : Object {
	private Gee.Map? _page_keys;

	/**
	 * Emitted when a navigation was requested.
	 *
	 * @param page The instance of the page to which navigation was requested.
	 */
	public signal void navigation_requested (Page page);

	/**
	 * Emitted when a navigation to the previous page in the history was
	 * requested.
	 *
	 * You can also use this signal as a method to request navigation.
	 */
	[Signal (action = true)]
	public signal void go_back ();

	/**
	 * Returns the page map associated with this navigation service.
	 *
	 * This method takes a type parameter that allows setting the type of the
	 * enum that will be used for the keys of this navigation service.
	 *
	 * Note: if you call this method with a different enum than the one you
	 * used in the previous call, a new page map will be created.
	 *
	 * @return The page map associated with this navigation service.
	 */
	public Gee.Map<TKey, Type> get_page_keys<TKey> () requires (typeof (TKey).is_enum ()) {
		if (this._page_keys != null && this._page_keys.key_type.is_a (typeof (TKey))) {
			return this._page_keys;
		}

		return (this._page_keys = new Gee.HashMap<TKey, Type> ());
	}

	/**
	 * Navigate to the page associated with the specified key.
	 *
	 * You can also set a parameter that will be passed to the page through the
	 * {@link Page.on_navigated_to} method.
	 *
	 * Note: If you use a different enum as a type parameter than the one you
	 * used in the call to {@link get_page_keys}, a new page map will be
	 * created.
	 *
	 * @param page_key The key associated with the page you want to navigate to.
	 * @param parameter The optional parameter that will be passed to the page
	 *                  when navigation occurs.
	 */
	public void navigate<TKey> (TKey page_key, Value? parameter = null) {
		Gee.Map<TKey, Type> page_keys = this.get_page_keys ();
		return_if_fail (page_keys.has_key (page_key));

		Type page_type = page_keys[page_key];
		assert (page_type.is_a (typeof (Page)));

		var page = (Page) Object.@new (page_type, navigation_service: this);

		this.navigation_requested (page);
		page.on_navigated_to (parameter);
	}
}
