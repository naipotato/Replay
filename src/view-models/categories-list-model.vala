namespace Unitube {

    public class CategoriesListModel : Object, ListModel {

        public Gee.List<Category> categories;

        public Object? get_item (uint position) {
            return categories[(int) position];
        }

        public Type get_item_type () {
            return typeof (Category);
        }

        public uint get_n_items () {
            return categories.size;
        }
    }
}
