/* view-category.vala
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
 * The possible values ​​for the category of a {@link View}.
 */
public enum Rpy.ViewCategory {
	/**
	 * The view is considered a primary view, which the user will navigate to
	 * frequently.
	 */
	PRIMARY,

	/**
	 * The view is considered a secondary view, to which the user will navigate
	 * to occasionally.
	 */
	SECONDARY;
}
