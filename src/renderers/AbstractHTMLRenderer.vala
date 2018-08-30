/*
 * Copyright (c) 2018 FriendOfEntropy (https://github.com/FriendOfEntropy/postapocrpgtools)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU LESSER GENERAL PUBLIC
 * LICENSE as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 * Authored by: FriendOfEntropy <FriendOfEntropy@gmail.com>
 */

namespace PostApocRPGTools.Renderers {

  public abstract class AbstractHTMLRenderer : Object {



    public string render_start_tag (string tag_name, string? class_name = null, string? id_name = null) {
			StringBuilder builder = new StringBuilder();
      builder.append("<");
      builder.append(tag_name);
      if (class_name != null) {
        builder.append(" class='%s'".printf (class_name));
      }
      if (id_name != null) {
        builder.append(" id='%s'".printf (id_name));
      }
      builder.append(">\n");
      return builder.str;
    }
    

    public string render_end_tag (string tag_name) {
			StringBuilder builder = new StringBuilder();
      builder.append("</%s>".printf (tag_name));
      builder.append("\n");
      return builder.str;
		}

  }
}