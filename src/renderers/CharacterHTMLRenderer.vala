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

using RPGCore;

namespace PostApocRPGTools.Renderers {

	public class CharacterHTMLRenderer : AbstractHTMLRenderer {

		public string render_all (Character c) throws Error {
			string result = "Error";

			try {
				File resource = File.new_for_uri ("resource:///data/test.html");
				if (resource.query_exists ()) {
					uint8[] contents;
					string etag_out;
					resource.load_contents (null, out contents, out etag_out);
					string htmlTemplate = (string) contents;

					result = htmlTemplate.replace ("<primeattributetable/>", render_prime_attributes (c));
					result = result.replace ("<mutationtable/>", render_mutations (c));
				}
			}
			catch (Error e) {
				throw e;
			}
			return result;
		}

		public string render_prime_attributes (Character c) {

			StringBuilder builder = new StringBuilder();

      builder.append (render_start_tag ("table", "primeAttributes"));
      builder.append ("<tr><th>Abbrev</th><th>Ability</th><th>Score</th><th>Modifier</th></tr>\n");

      Ability ability = c.abilities.get("STR");
      builder.append (render_ability_row(ability));
  
      ability = c.abilities.get("DEX");
      builder.append (render_ability_row(ability));
  
      ability = c.abilities.get("CON");
      builder.append (render_ability_row(ability));
  
      ability = c.abilities.get("INT");
      builder.append (render_ability_row(ability));
  
      ability = c.abilities.get("WIS");
      builder.append (render_ability_row(ability));
  
      ability = c.abilities.get("CHA");
      builder.append (render_ability_row(ability));

      builder.append (render_end_tag ("table"));

      return builder.str;
		}


    private string render_ability_row(Ability ability) {
      StringBuilder builder = new StringBuilder();
      builder.append (render_start_tag ("tr", null));
      builder.append("<td>%s</td>".printf (ability.abbreviation));
      builder.append("<td>" + ability.name + "</td>");
      builder.append("<td>" + ability.score.to_string() + "</td>");
      builder.append("<td>" + ability.modifier.to_string() + "</td>");
			builder.append (render_end_tag ("tr"));
      return builder.str;
    }


		public string render_mutations (Character c) {
			StringBuilder builder = new StringBuilder();
			builder.append (render_start_tag ("table", "mutations"));
			builder.append ("<tr><th>Name</th></tr>\n");
			foreach (var entry in c.mutations.entries) {
				Mutation mut = entry.value;
				builder.append ("<tr><td>" + mut.name + "</td></tr>");
			}
			
			builder.append (render_end_tag ("table"));
			return builder.str;
		}

		public string render_defects () {
			return "";
		}


	}
}