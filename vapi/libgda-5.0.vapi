[CCode (cprefix = "Gda", gir_namespace = "Gda", gir_version = "5.0", lower_case_cprefix = "gda_")]
namespace Gda {
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_batch_get_type ()")]
    public class Batch : GLib.Object {
        [CCode (has_construct_function = false)]
        public Batch ();
        public void add_statement (Gda.Statement stmt);
        public Gda.Batch copy ();
        public static GLib.Quark error_quark ();
        public bool get_parameters (out Gda.Set out_params) throws GLib.Error;
        public unowned GLib.SList<Gda.Statement> get_statements ();
        public void remove_statement (Gda.Statement stmt);
        public string serialize ();
        public virtual signal void changed (GLib.Object changed_stmt);
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gda_binary_get_type ()")]
    [Compact]
    public class Binary {
        public long binary_length;
        [CCode (array_length = false)]
        public weak uint8[] data;
        public static void* copy (void* boxed);
        public static void free (owned void* boxed);
        public string to_string (uint maxlen);
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gda_blob_get_type ()")]
    [Compact]
    public class Blob {
        public weak Gda.Binary data;
        public weak Gda.BlobOp op;
        public static void* copy (void* boxed);
        public static void free (owned void* boxed);
        public void set_op (Gda.BlobOp? op);
        public string to_string (uint maxlen);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_blob_op_get_type ()")]
    public abstract class BlobOp : GLib.Object {
        public void* _gda_reserved1;
        [CCode (has_construct_function = false)]
        protected BlobOp ();
        public virtual long get_length ();
        public virtual long read (Gda.Blob blob, long offset, long size);
        public bool read_all (Gda.Blob blob);
        public virtual long write (Gda.Blob blob, long offset);
        public virtual bool write_all (Gda.Blob blob);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_column_get_type ()")]
    public class Column : GLib.Object {
        [CCode (has_construct_function = false)]
        public Column ();
        public Gda.Column copy ();
        public bool get_allow_null ();
        public unowned GLib.Value? get_attribute (string attribute);
        public bool get_auto_increment ();
        public unowned string get_dbms_type ();
        public unowned GLib.Value? get_default_value ();
        public unowned string get_description ();
        public GLib.Type get_g_type ();
        public unowned string get_name ();
        public int get_position ();
        public void set_allow_null (bool allow);
        public void set_attribute (string attribute, GLib.Value? value, GLib.DestroyNotify? destroy);
        public void set_auto_increment (bool is_auto);
        public void set_dbms_type (string dbms_type);
        public void set_default_value (GLib.Value? default_value);
        public void set_description (string title);
        public void set_g_type (GLib.Type type);
        public void set_name (string name);
        public void set_position (int position);
        [NoAccessorMethod]
        public string id { owned get; set; }
        public virtual signal void g_type_changed (GLib.Type old_type, GLib.Type new_type);
        public virtual signal void name_changed (string old_name);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_config_get_type ()")]
    public class Config : GLib.Object {
        [CCode (has_construct_function = false)]
        protected Config ();
        public static bool can_modify_system_config ();
        public static bool define_dsn (Gda.DsnInfo info) throws GLib.Error;
        public static bool dsn_needs_authentication (string dsn_name);
        public static GLib.Quark error_quark ();
        public static Gda.Config @get ();
        public static unowned Gda.DsnInfo get_dsn_info (string dsn_name);
        public static unowned Gda.DsnInfo get_dsn_info_at_index (int index);
        public static int get_dsn_info_index (string dsn_name);
        public static int get_nb_dsn ();
        public static unowned Gda.ServerProvider get_provider (string provider_name) throws GLib.Error;
        public static unowned Gda.ProviderInfo? get_provider_info (string provider_name);
        public static Gda.DataModel list_dsn ();
        public static Gda.DataModel list_providers ();
        public static bool remove_dsn (string dsn_name) throws GLib.Error;
        [NoAccessorMethod]
        public string system_filename { owned get; set; }
        [NoAccessorMethod]
        public string user_filename { owned get; set; }
        public virtual signal void dsn_added (void* new_dsn);
        public virtual signal void dsn_changed (void* dsn);
        public virtual signal void dsn_removed (void* old_dsn);
        public virtual signal void dsn_to_be_removed (void* old_dsn);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_connection_get_type ()")]
    public class Connection : GLib.Object, Gda.Lockable {
        [CCode (has_construct_function = false)]
        protected Connection ();
        public void add_event (owned Gda.ConnectionEvent event);
        public void add_prepared_statement (Gda.Statement gda_stmt, Gda.PStmt prepared_stmt);
        public bool add_savepoint (string? name) throws GLib.Error;
        [Version (since = "4.2")]
        public bool async_cancel (uint task_id) throws GLib.Error;
        [Version (since = "4.2")]
        public GLib.Object async_fetch_result (uint task_id, out Gda.Set last_insert_row) throws GLib.Error;
        [Version (since = "4.2")]
        public uint async_statement_execute (Gda.Statement stmt, Gda.Set? @params, Gda.StatementModelUsage model_usage, [CCode (array_length = false)] GLib.Type[]? col_types, bool need_last_insert_row) throws GLib.Error;
        public GLib.SList<GLib.Object> batch_execute (Gda.Batch batch, Gda.Set? @params, Gda.StatementModelUsage model_usage) throws GLib.Error;
        public bool begin_transaction (string? name, Gda.TransactionIsolation level) throws GLib.Error;
        public void clear_events_list ();
        public void close ();
        public void close_no_warning ();
        public bool commit_transaction (string? name) throws GLib.Error;
        public Gda.ServerOperation create_operation (Gda.ServerOperationType type, Gda.Set? options) throws GLib.Error;
        public Gda.SqlParser create_parser ();
        public void del_prepared_statement (Gda.Statement gda_stmt);
        [Version (since = "4.2.3")]
        public bool delete_row_from_table (string table, string condition_column_name, GLib.Value condition_value) throws GLib.Error;
        public bool delete_savepoint (string? name) throws GLib.Error;
        public static GLib.Quark error_quark ();
        [Version (since = "4.2.3")]
        public int execute_non_select_command (string sql) throws GLib.Error;
        [Version (since = "4.2.3")]
        public Gda.DataModel execute_select_command (string sql) throws GLib.Error;
        [CCode (has_construct_function = false)]
        [Version (since = "5.0.2")]
        public Connection.from_dsn (string dsn, string? auth_string, Gda.ConnectionOptions options) throws GLib.Error;
        [CCode (has_construct_function = false)]
        [Version (since = "5.0.2")]
        public Connection.from_string (string? provider_name, string cnc_string, string? auth_string, Gda.ConnectionOptions options) throws GLib.Error;
        public unowned string get_authentication ();
        public unowned string get_cnc_string ();
        [Version (since = "5.2")]
        public bool get_date_format (out GLib.DateDMY out_first, out GLib.DateDMY out_second, out GLib.DateDMY out_third, out string out_sep) throws GLib.Error;
        public unowned string get_dsn ();
        public unowned GLib.List<Gda.ConnectionEvent> get_events ();
        public unowned Gda.MetaStore get_meta_store ();
        public Gda.DataModel get_meta_store_data_v (Gda.ConnectionMetaType meta_type, GLib.List<Gda.Holder> filters) throws GLib.Error;
        public Gda.ConnectionOptions get_options ();
        public unowned Gda.PStmt get_prepared_statement (Gda.Statement gda_stmt);
        public unowned Gda.ServerProvider get_provider ();
        public unowned string get_provider_name ();
        public unowned Gda.TransactionStatus get_transaction_status ();
        [Version (since = "4.2.3")]
        public bool insert_row_into_table_v (string table, GLib.SList<string> col_names, GLib.SList<GLib.Value?> values) throws GLib.Error;
        public bool is_opened ();
        public bool open () throws GLib.Error;
        public static Gda.Connection open_from_dsn (string dsn, string? auth_string, Gda.ConnectionOptions options) throws GLib.Error;
        public static Gda.Connection open_from_string (string? provider_name, string cnc_string, string? auth_string, Gda.ConnectionOptions options) throws GLib.Error;
        public static Gda.Connection open_sqlite (string? directory, string filename, bool auto_unlink);
        [Version (since = "4.2.3")]
        public Gda.Statement parse_sql_string (string sql, out Gda.Set @params) throws GLib.Error;
        public bool perform_operation (Gda.ServerOperation op) throws GLib.Error;
        [Version (since = "4.2")]
        public Gda.ConnectionEvent point_available_event (Gda.ConnectionEventType type);
        [Version (since = "4.0.3")]
        public string quote_sql_identifier (string id);
        [Version (since = "4.2")]
        public GLib.SList<GLib.Object> repetitive_statement_execute (Gda.RepetitiveStatement rstmt, Gda.StatementModelUsage model_usage, [CCode (array_length = false)] GLib.Type[]? col_types, bool stop_on_error) throws GLib.Error;
        public bool rollback_savepoint (string? name) throws GLib.Error;
        public bool rollback_transaction (string? name) throws GLib.Error;
        public GLib.Object statement_execute (Gda.Statement stmt, Gda.Set? @params, Gda.StatementModelUsage model_usage, out Gda.Set last_insert_row) throws GLib.Error;
        public int statement_execute_non_select (Gda.Statement stmt, Gda.Set? @params, out Gda.Set last_insert_row) throws GLib.Error;
        public Gda.DataModel statement_execute_select (Gda.Statement stmt, Gda.Set? @params) throws GLib.Error;
        public Gda.DataModel statement_execute_select_full (Gda.Statement stmt, Gda.Set? @params, Gda.StatementModelUsage model_usage, [CCode (array_length = false)] GLib.Type[]? col_types) throws GLib.Error;
        public bool statement_prepare (Gda.Statement stmt) throws GLib.Error;
        public string statement_to_sql (Gda.Statement stmt, Gda.Set? @params, Gda.StatementSqlFlag flags, out GLib.SList<weak Gda.Holder> params_used) throws GLib.Error;
        public static void string_split (string string, string out_cnc_params, string out_provider, string out_username, string? out_password);
        public bool supports_feature (Gda.ConnectionFeature feature);
        public bool update_meta_store (Gda.MetaContext? context) throws GLib.Error;
        [Version (since = "4.2.3")]
        public bool update_row_in_table_v (string table, string condition_column_name, GLib.Value condition_value, GLib.SList<string> col_names, GLib.SList<GLib.Value?> values) throws GLib.Error;
        public string value_to_sql_string (GLib.Value from);
        [NoAccessorMethod]
        public string auth_string { owned get; set; }
        [NoAccessorMethod]
        public string cnc_string { owned get; set; }
        [NoAccessorMethod]
        public string dsn { owned get; set; }
        [NoAccessorMethod]
        [Version (since = "4.2")]
        public int events_history_size { get; set; }
        [NoAccessorMethod]
        [Version (since = "5.2.0")]
        public uint execution_slowdown { get; set; }
        [NoAccessorMethod]
        [Version (since = "4.2.9")]
        public bool execution_timer { get; set; }
        [NoAccessorMethod]
        [Version (since = "4.2")]
        public bool is_wrapper { get; set; }
        [NoAccessorMethod]
        public Gda.MetaStore meta_store { owned get; set; }
        [NoAccessorMethod]
        [Version (since = "4.2")]
        public bool monitor_wrapped_in_mainloop { get; set; }
        [NoAccessorMethod]
        public Gda.ServerProvider provider { owned get; set; }
        [NoAccessorMethod]
        public void* thread_owner { get; set; }
        public virtual signal void conn_closed ();
        public virtual signal void conn_opened ();
        public virtual signal void conn_to_close ();
        public virtual signal void dsn_changed ();
        public virtual signal void error (Gda.ConnectionEvent error);
        public virtual signal void transaction_status_changed ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_connection_event_get_type ()")]
    public class ConnectionEvent : GLib.Object {
        [CCode (has_construct_function = false)]
        protected ConnectionEvent ();
        public long get_code ();
        public unowned string get_description ();
        public Gda.ConnectionEventType get_event_type ();
        public Gda.ConnectionEventCode get_gda_code ();
        public unowned string get_source ();
        public unowned string get_sqlstate ();
        public void set_code (long code);
        public void set_description (string? description);
        public void set_event_type (Gda.ConnectionEventType type);
        public void set_gda_code (Gda.ConnectionEventCode code);
        public void set_source (string source);
        public void set_sqlstate (string sqlstate);
        [NoAccessorMethod]
        public int type { get; set; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_data_access_wrapper_get_type ()")]
    public class DataAccessWrapper : GLib.Object, Gda.DataModel {
        [CCode (has_construct_function = false)]
        protected DataAccessWrapper ();
        public static Gda.DataModel @new (Gda.DataModel model);
        [Version (since = "5.2")]
        public bool set_mapping ([CCode (array_length_cname = "mapping_size", array_length_pos = 1.1)] int[]? mapping);
        [NoAccessorMethod]
        public Gda.DataModel model { owned get; construct; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_data_comparator_get_type ()")]
    public class DataComparator : GLib.Object {
        [CCode (has_construct_function = false, type = "GObject*")]
        public DataComparator (Gda.DataModel old_model, Gda.DataModel new_model);
        public bool compute_diff () throws GLib.Error;
        public static GLib.Quark error_quark ();
        public unowned Gda.Diff? get_diff (int pos);
        public int get_n_diffs ();
        public void set_key_columns ([CCode (array_length_cname = "nb_cols", array_length_pos = 1.1)] int[] col_numbers);
        [NoAccessorMethod]
        public Gda.DataModel new_model { owned get; set; }
        [NoAccessorMethod]
        public Gda.DataModel old_model { owned get; set; }
        public virtual signal bool diff_computed (void* diff);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_data_model_array_get_type ()")]
    public class DataModelArray : GLib.Object, Gda.DataModel {
        [CCode (has_construct_function = false)]
        protected DataModelArray ();
        public void clear ();
        public unowned Gda.Row get_row (int row) throws GLib.Error;
        public static Gda.DataModel @new (int cols);
        [Version (since = "4.2.6")]
        public static Gda.DataModel new_with_g_types_v (int cols, [CCode (array_length = false)] GLib.Type[] types);
        public void set_n_columns (int cols);
        [NoAccessorMethod]
        public uint n_columns { get; set; }
        [NoAccessorMethod]
        public bool read_only { get; set; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_data_model_dir_get_type ()")]
    public class DataModelDir : GLib.Object, Gda.DataModel {
        [CCode (has_construct_function = false)]
        protected DataModelDir ();
        public void clean_errors ();
        public unowned GLib.SList<GLib.Error> get_errors ();
        public static Gda.DataModel @new (string basedir);
        [NoAccessorMethod]
        public string basedir { owned get; construct; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_data_model_import_get_type ()")]
    public class DataModelImport : GLib.Object, Gda.DataModel {
        [CCode (has_construct_function = false)]
        protected DataModelImport ();
        public void clean_errors ();
        public unowned GLib.SList<GLib.Error> get_errors ();
        public static Gda.DataModel new_file (string filename, bool random_access, Gda.Set? options);
        public static Gda.DataModel new_mem (string data, bool random_access, Gda.Set? options);
        public static Gda.DataModel new_xml_node ([CCode (type = "xmlNodePtr")] Xml.Node* node);
        [NoAccessorMethod]
        public string data_string { owned get; construct; }
        [NoAccessorMethod]
        public string filename { owned get; construct; }
        [NoAccessorMethod]
        public Gda.Set options { owned get; construct; }
        [NoAccessorMethod]
        public bool random_access { get; construct; }
        [NoAccessorMethod]
        [Version (since = "4.2.1")]
        public bool strict { get; set construct; }
        [NoAccessorMethod]
        public void* xml_node { get; construct; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_data_model_iter_get_type ()")]
    public class DataModelIter : Gda.Set {
        [CCode (has_construct_function = false)]
        protected DataModelIter ();
        public static GLib.Quark error_quark ();
        [Version (deprecated = true, deprecated_since = "5.2")]
        public int get_column_for_param (Gda.Holder param);
        public unowned Gda.Holder get_holder_for_field (int col);
        public int get_row ();
        public unowned GLib.Value? get_value_at (int col);
        [Version (since = "4.2.10")]
        public unowned GLib.Value? get_value_at_e (int col) throws GLib.Error;
        public unowned GLib.Value? get_value_for_field (string field_name);
        public void invalidate_contents ();
        public bool is_valid ();
        public bool move_next ();
        public bool move_prev ();
        public bool move_to_row (int row);
        public bool set_value_at (int col, GLib.Value value) throws GLib.Error;
        [NoAccessorMethod]
        public int current_row { get; set; }
        [NoAccessorMethod]
        public Gda.DataModel data_model { owned get; set construct; }
        [NoAccessorMethod]
        public Gda.DataModel forced_model { owned get; set; }
        [NoAccessorMethod]
        public bool update_model { get; set; }
        public virtual signal void end_of_data ();
        public virtual signal void row_changed (int row);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_data_pivot_get_type ()")]
    public class DataPivot : GLib.Object, Gda.DataModel {
        [CCode (has_construct_function = false)]
        protected DataPivot ();
        [Version (since = "5.0")]
        public bool add_data (Gda.DataPivotAggregate aggregate_type, string field, string? alias) throws GLib.Error;
        [Version (since = "5.0")]
        public bool add_field (Gda.DataPivotFieldType field_type, string field, string? alias) throws GLib.Error;
        public static GLib.Quark error_quark ();
        public static Gda.DataModel @new (Gda.DataModel? model);
        [Version (since = "5.0")]
        public bool populate () throws GLib.Error;
        [NoAccessorMethod]
        public Gda.DataModel model { owned get; set; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_data_proxy_get_type ()")]
    public class DataProxy : GLib.Object, Gda.DataModel {
        [CCode (has_construct_function = false, type = "GObject*")]
        public DataProxy (Gda.DataModel model);
        public void alter_value_attributes (int proxy_row, int col, Gda.ValueAttribute alter_flags);
        public bool apply_all_changes () throws GLib.Error;
        public bool apply_row_changes (int proxy_row) throws GLib.Error;
        public bool cancel_all_changes ();
        public void cancel_row_changes (int proxy_row, int col);
        public void @delete (int proxy_row);
        public static GLib.Quark error_quark ();
        public unowned string get_filter_expr ();
        public int get_filtered_n_rows ();
        public int get_n_modified_rows ();
        public int get_n_new_rows ();
        public unowned Gda.DataModel get_proxied_model ();
        public int get_proxied_model_n_cols ();
        public int get_proxied_model_n_rows ();
        public int get_proxied_model_row (int proxy_row);
        public int get_sample_end ();
        public int get_sample_size ();
        public int get_sample_start ();
        public Gda.ValueAttribute get_value_attributes (int proxy_row, int col);
        public GLib.SList<weak GLib.Value?> get_values (int proxy_row, [CCode (array_length_cname = "n_cols", array_length_pos = 2.1)] int[] cols_index);
        public bool has_changed ();
        public bool is_read_only ();
        public bool row_has_changed (int proxy_row);
        public bool row_is_deleted (int proxy_row);
        public bool row_is_inserted (int proxy_row);
        public bool set_filter_expr (string? filter_expr) throws GLib.Error;
        public bool set_ordering_column (int col) throws GLib.Error;
        public void set_sample_size (int sample_size);
        public void set_sample_start (int sample_start);
        public void undelete (int proxy_row);
        [CCode (has_construct_function = false)]
        [Version (since = "5.2.0")]
        public DataProxy.with_data_model (Gda.DataModel model);
        [NoAccessorMethod]
        [Version (since = "5.2")]
        public bool cache_changes { get; set; }
        [NoAccessorMethod]
        public bool defer_sync { get; set; }
        [NoAccessorMethod]
        public Gda.DataModel model { owned get; set construct; }
        [NoAccessorMethod]
        public bool prepend_null_entry { get; set; }
        public int sample_size { get; set construct; }
        public virtual signal void filter_changed ();
        public virtual signal void row_changes_applied (int row, int proxied_row);
        public virtual signal void row_delete_changed (int row, bool to_be_deleted);
        public virtual signal void sample_changed (int sample_start, int sample_end);
        public virtual signal void sample_size_changed (int sample_size);
        public virtual signal GLib.Error validate_row_changes (int row, int proxied_row);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_data_select_get_type ()")]
    public abstract class DataSelect : GLib.Object, Gda.DataModel {
        public int advertized_nrows;
        public int nb_stored_rows;
        public weak Gda.PStmt prep_stmt;
        [CCode (has_construct_function = false)]
        protected DataSelect ();
        public bool compute_columns_attributes () throws GLib.Error;
        public bool compute_modification_statements () throws GLib.Error;
        [Version (since = "4.2.9")]
        public bool compute_modification_statements_ext (Gda.DataSelectConditionType cond_type) throws GLib.Error;
        public bool compute_row_selection_condition () throws GLib.Error;
        public static GLib.Quark error_quark ();
        [NoWrapper]
        public virtual bool fetch_at (Gda.Row prow, int rownum) throws GLib.Error;
        [NoWrapper]
        public virtual int fetch_nb_rows ();
        [NoWrapper]
        public virtual bool fetch_next (Gda.Row prow, int rownum) throws GLib.Error;
        [NoWrapper]
        public virtual bool fetch_prev (Gda.Row prow, int rownum) throws GLib.Error;
        [NoWrapper]
        public virtual bool fetch_random (Gda.Row prow, int rownum) throws GLib.Error;
        public unowned Gda.Connection get_connection ();
        [Version (since = "5.2.0")]
        public bool prepare_for_offline () throws GLib.Error;
        [Version (since = "4.2")]
        public bool rerun () throws GLib.Error;
        public bool set_modification_statement (Gda.Statement mod_stmt) throws GLib.Error;
        public bool set_modification_statement_sql (string sql) throws GLib.Error;
        public bool set_row_selection_condition_sql (string sql_where) throws GLib.Error;
        [NoWrapper]
        public virtual bool store_all () throws GLib.Error;
        [NoAccessorMethod]
        public bool auto_reset { get; set; }
        public Gda.Connection connection { get; construct; }
        [NoAccessorMethod]
        public Gda.Statement delete_stmt { owned get; set; }
        [NoAccessorMethod]
        public Gda.Set exec_params { owned get; construct; }
        [NoAccessorMethod]
        [Version (since = "4.2.9")]
        public double execution_delay { get; set; }
        [NoAccessorMethod]
        public Gda.Statement insert_stmt { owned get; set; }
        [NoAccessorMethod]
        public uint model_usage { get; construct; }
        [NoAccessorMethod]
        public Gda.PStmt prepared_stmt { owned get; set; }
        [NoAccessorMethod]
        public Gda.Statement select_stmt { owned get; }
        [NoAccessorMethod]
        public bool store_all_rows { get; set; }
        [NoAccessorMethod]
        public Gda.Statement update_stmt { owned get; set; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gda_default_get_type ()")]
    [Compact]
    public class Default {
        public static string escape_string (string string);
        public static string unescape_string (string string);
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gda_dsn_info_get_type ()")]
    [Compact]
    public class DsnInfo {
        public weak string auth_string;
        public weak string cnc_string;
        public weak string description;
        public bool is_system;
        public weak string name;
        public weak string provider;
        [CCode (has_construct_function = false)]
        [Version (since = "5.2")]
        public DsnInfo ();
        [Version (since = "5.2")]
        public Gda.DsnInfo copy ();
        [Version (since = "5.2")]
        public void free ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", lower_case_csuffix = "geometricpoint", type_id = "gda_geometricpoint_get_type ()")]
    [Compact]
    public class GeometricPoint {
        public double x;
        public double y;
        public static void* copy (void* boxed);
        public static void free (void* boxed);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_handler_bin_get_type ()")]
    public class HandlerBin : GLib.Object, Gda.DataHandler {
        [CCode (has_construct_function = false)]
        protected HandlerBin ();
        public static Gda.DataHandler @new ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class HandlerBinPriv {
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_handler_boolean_get_type ()")]
    public class HandlerBoolean : GLib.Object, Gda.DataHandler {
        [CCode (has_construct_function = false)]
        protected HandlerBoolean ();
        public static Gda.DataHandler @new ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class HandlerBooleanPriv {
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_handler_numerical_get_type ()")]
    public class HandlerNumerical : GLib.Object, Gda.DataHandler {
        [CCode (has_construct_function = false)]
        protected HandlerNumerical ();
        public static Gda.DataHandler @new ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class HandlerNumericalPriv {
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_handler_string_get_type ()")]
    public class HandlerString : GLib.Object, Gda.DataHandler {
        [CCode (has_construct_function = false)]
        protected HandlerString ();
        public static Gda.DataHandler @new ();
        public static Gda.DataHandler new_with_provider (Gda.ServerProvider prov, Gda.Connection? cnc);
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class HandlerStringPriv {
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_handler_time_get_type ()")]
    public class HandlerTime : GLib.Object, Gda.DataHandler {
        [CCode (has_construct_function = false)]
        protected HandlerTime ();
        public string get_format (GLib.Type type);
        public string get_no_locale_str_from_value (GLib.Value value);
        public static Gda.DataHandler @new ();
        public static Gda.DataHandler new_no_locale ();
        public void set_sql_spec (GLib.DateDMY first, GLib.DateDMY sec, GLib.DateDMY third, char separator, bool twodigits_years);
        [Version (since = "4.2.1")]
        public void set_str_spec (GLib.DateDMY first, GLib.DateDMY sec, GLib.DateDMY third, char separator, bool twodigits_years);
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class HandlerTimePriv {
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_handler_type_get_type ()")]
    public class HandlerType : GLib.Object, Gda.DataHandler {
        [CCode (has_construct_function = false)]
        protected HandlerType ();
        public static Gda.DataHandler @new ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class HandlerTypePriv {
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_holder_get_type ()")]
    public class Holder : GLib.Object, Gda.Lockable {
        [CCode (has_construct_function = false)]
        public Holder (GLib.Type type);
        [NoWrapper]
        public virtual void att_changed (string att_name, GLib.Value att_value);
        public Gda.Holder copy ();
        public static GLib.Quark error_quark ();
        public void force_invalid ();
        [Version (since = "4.2.10")]
        public void force_invalid_e (owned GLib.Error? error);
        public string get_alphanum_id ();
        public unowned GLib.Value? get_attribute (string attribute);
        public unowned Gda.Holder get_bind ();
        public unowned GLib.Value? get_default_value ();
        public GLib.Type get_g_type ();
        public unowned string get_id ();
        public bool get_not_null ();
        public unowned Gda.DataModel get_source_model (int col);
        public unowned GLib.Value? get_value ();
        public string get_value_str (Gda.DataHandler? dh);
        public bool is_valid ();
        [Version (since = "4.2.10")]
        public bool is_valid_e () throws GLib.Error;
        public void set_attribute (string attribute, GLib.Value value, GLib.DestroyNotify destroy);
        public bool set_bind (Gda.Holder bind_to) throws GLib.Error;
        public void set_default_value (GLib.Value value);
        public void set_not_null (bool not_null);
        public bool set_source_model (Gda.DataModel model, int col) throws GLib.Error;
        public bool set_value (GLib.Value? value) throws GLib.Error;
        public bool set_value_str (Gda.DataHandler dh, string value) throws GLib.Error;
        public bool set_value_to_default ();
        public GLib.Value? take_static_value (GLib.Value value, bool value_changed) throws GLib.Error;
        public bool take_value (owned GLib.Value value) throws GLib.Error;
        public bool value_is_default ();
        [NoAccessorMethod]
        public string description { owned get; set; }
        [NoAccessorMethod]
        public Gda.Holder full_bind { owned get; set; }
        [NoAccessorMethod]
        public GLib.Type g_type { get; set construct; }
        [NoAccessorMethod]
        public string id { owned get; set; }
        [NoAccessorMethod]
        public string name { owned get; set; }
        public bool not_null { get; set; }
        [NoAccessorMethod]
        public Gda.Holder simple_bind { owned get; set; }
        [NoAccessorMethod]
        public int source_column { get; set; }
        [NoAccessorMethod]
        public Gda.DataModel source_model { owned get; set; }
        [NoAccessorMethod]
        [Version (since = "5.2.0")]
        public bool validate_changes { get; set; }
        public signal void attribute_changed (string att_name, GLib.Value att_value);
        public virtual signal void changed ();
        public virtual signal void source_changed ();
        public virtual signal GLib.Error validate_change (GLib.Value new_value);
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gda_meta_context_get_type ()")]
    [Compact]
    public class MetaContext {
        [CCode (array_length_cname = "size")]
        public weak string[] column_names;
        [CCode (array_length_cname = "size")]
        public weak GLib.Value[] column_values;
        public weak GLib.HashTable<string,GLib.Value?> columns;
        public int size;
        public weak string table_name;
        [CCode (has_construct_function = false)]
        [Version (since = "5.2")]
        public MetaContext ();
        [Version (since = "5.2")]
        public Gda.MetaContext copy ();
        [Version (since = "5.2")]
        public void free ();
        [Version (since = "5.2")]
        public unowned string get_table ();
        [Version (since = "5.2")]
        public void set_column (string column, GLib.Value value, Gda.Connection? cnc);
        [Version (since = "5.2")]
        public void set_columns (GLib.HashTable<string,GLib.Value?> columns, Gda.Connection? cnc);
        [Version (since = "5.2")]
        public void set_table (string table);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_meta_store_get_type ()")]
    public class MetaStore : GLib.Object {
        [CCode (has_construct_function = false)]
        public MetaStore (string? cnc_string);
        public Gda.DataModel create_modify_data_model (string table_name);
        [Version (since = "4.2.4")]
        public bool declare_foreign_key (Gda.MetaStruct? mstruct, string fk_name, string? catalog, string? schema, string table, string? ref_catalog, string? ref_schema, string ref_table, [CCode (array_length_cname = "nb_cols", array_length_pos = 8.5, array_length_type = "guint")] string[] colnames, [CCode (array_length_cname = "nb_cols", array_length_pos = 8.5, array_length_type = "guint")] string[] ref_colnames) throws GLib.Error;
        public static GLib.Quark error_quark ();
        [CCode (cname = "gda_meta_store_extract_v")]
        [Version (since = "4.2.6")]
        public Gda.DataModel extract (string select_sql, GLib.HashTable<string,GLib.Value?>? vars) throws GLib.Error;
        public bool get_attribute_value (string att_name, out string att_value) throws GLib.Error;
        public unowned Gda.Connection get_internal_connection ();
        public int get_version ();
        [Version (since = "4.2.6")]
        public bool modify_v (string table_name, Gda.DataModel? new_data, string? condition, [CCode (array_length_cname = "nvalues", array_length_pos = 3.5)] string[] value_names, [CCode (array_length_cname = "nvalues", array_length_pos = 3.5)] GLib.Value[] values) throws GLib.Error;
        public bool modify_with_context (Gda.MetaContext context, Gda.DataModel? new_data) throws GLib.Error;
        public bool schema_add_custom_object (string xml_description) throws GLib.Error;
        public GLib.SList<weak string> schema_get_all_tables ();
        public GLib.SList<weak string> schema_get_depend_tables (string table_name);
        public Gda.MetaStruct schema_get_structure () throws GLib.Error;
        public bool schema_remove_custom_object (string obj_name) throws GLib.Error;
        public bool set_attribute_value (string att_name, string? att_value) throws GLib.Error;
        [Version (since = "4.2")]
        public void set_identifiers_style (Gda.SqlIdentifierStyle style);
        [Version (since = "4.2")]
        public void set_reserved_keywords_func (Gda.SqlReservedKeywordsFunc? func);
        [Version (since = "4.0.3")]
        public static string sql_identifier_quote (string id, Gda.Connection cnc);
        [Version (since = "4.2.4")]
        public bool undeclare_foreign_key (Gda.MetaStruct? mstruct, string fk_name, string? catalog, string? schema, string table, string? ref_catalog, string? ref_schema, string ref_table) throws GLib.Error;
        [CCode (has_construct_function = false)]
        public MetaStore.with_file (string file_name);
        [NoAccessorMethod]
        public string catalog { construct; }
        [NoAccessorMethod]
        public Gda.Connection cnc { owned get; construct; }
        [NoAccessorMethod]
        public string cnc_string { construct; }
        [NoAccessorMethod]
        public string schema { construct; }
        public signal void meta_changed (GLib.SList<Gda.MetaStoreChange?> changes);
        public virtual signal void meta_reset ();
        public virtual signal GLib.Error suggest_update (Gda.MetaContext suggest);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_meta_struct_get_type ()")]
    public class MetaStruct : GLib.Object {
        [CCode (has_construct_function = false)]
        public MetaStruct (Gda.MetaStore store, Gda.MetaStructFeature features);
        public unowned Gda.MetaDbObject? complement (Gda.MetaDbObjectType type, GLib.Value? catalog, GLib.Value? schema, GLib.Value name) throws GLib.Error;
        public bool complement_all () throws GLib.Error;
        public bool complement_default () throws GLib.Error;
        public bool complement_depend (Gda.MetaDbObject dbo) throws GLib.Error;
        public bool complement_schema (GLib.Value? catalog, GLib.Value? schema) throws GLib.Error;
        public string dump_as_graph (Gda.MetaGraphInfo info) throws GLib.Error;
        public static GLib.Quark error_quark ();
        public GLib.SList<weak Gda.MetaDbObject?> get_all_db_objects ();
        public unowned Gda.MetaDbObject? get_db_object (GLib.Value? catalog, GLib.Value? schema, GLib.Value name);
        public bool load_from_xml_file (string? catalog, string? schema, string xml_spec_file) throws GLib.Error;
        public bool sort_db_objects (Gda.MetaSortType sort_type) throws GLib.Error;
        [NoAccessorMethod]
        public uint features { get; construct; }
        [NoAccessorMethod]
        public Gda.MetaStore meta_store { owned get; construct; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gda_null_get_type ()")]
    [Compact]
    public class Null {
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gda_numeric_get_type ()")]
    [Compact]
    public class Numeric {
        public weak string number;
        public long precision;
        public long width;
        [CCode (has_construct_function = false)]
        [Version (since = "5.0.2")]
        public Numeric ();
        public Gda.Numeric copy ();
        [DestroysInstance]
        public void free ();
        [Version (since = "5.0.2")]
        public double get_double ();
        [Version (since = "5.0.2")]
        public long get_precision ();
        [Version (since = "5.0.2")]
        public string? get_string ();
        [Version (since = "5.0.2")]
        public long get_width ();
        [Version (since = "5.0.2")]
        public void set_double (double number);
        [Version (since = "5.0.2")]
        public void set_from_string (string str);
        [Version (since = "5.0.2")]
        public void set_precision (long precision);
        [Version (since = "5.0.2")]
        public void set_width (long width);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_pstmt_get_type ()")]
    public abstract class PStmt : GLib.Object {
        public int ncols;
        public weak GLib.SList<string> param_ids;
        public weak string sql;
        public weak GLib.SList<Gda.Column> tmpl_columns;
        public GLib.Type types;
        [CCode (has_construct_function = false)]
        protected PStmt ();
        public void copy_contents (Gda.PStmt dest);
        public unowned Gda.Statement get_gda_statement ();
        public void set_gda_statement (Gda.Statement? stmt);
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gda_quark_list_get_type ()")]
    [Compact]
    public class QuarkList {
        [CCode (has_construct_function = false)]
        public QuarkList ();
        public void add_from_string (string string, bool cleanup);
        public void clear ();
        public Gda.QuarkList copy ();
        public unowned string find (string name);
        public void @foreach (GLib.HFunc func);
        public void free ();
        [CCode (has_construct_function = false)]
        public QuarkList.from_string (string string);
        [Version (since = "5.2.0")]
        public void protect_values ();
        public void remove (string name);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_repetitive_statement_get_type ()")]
    public class RepetitiveStatement : GLib.Object {
        [CCode (has_construct_function = false)]
        [Version (since = "4.2")]
        public RepetitiveStatement (Gda.Statement stmt);
        [Version (since = "4.2")]
        public bool append_set (Gda.Set values, bool make_copy);
        [Version (since = "4.2")]
        public GLib.SList<weak Gda.Set> get_all_sets ();
        [Version (since = "4.2")]
        public bool get_template_set (Gda.Set @set) throws GLib.Error;
        [NoAccessorMethod]
        public Gda.Statement statement { owned get; construct; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_row_get_type ()")]
    public class Row : GLib.Object {
        [CCode (has_construct_function = false)]
        public Row (int count);
        public int get_length ();
        public unowned GLib.Value? get_value (int num);
        public void invalidate_value (GLib.Value value);
        [Version (since = "4.2.10")]
        public void invalidate_value_e (GLib.Value value, owned GLib.Error? error);
        public bool value_is_valid (GLib.Value value);
        [Version (since = "4.2.10")]
        public bool value_is_valid_e (GLib.Value value) throws GLib.Error;
        [NoAccessorMethod]
        public int nb_values { set; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_server_operation_get_type ()")]
    public class ServerOperation : GLib.Object {
        [CCode (has_construct_function = false)]
        public ServerOperation (Gda.ServerOperationType op_type, string xml_file);
        public uint add_item_to_sequence (string seq_path);
        public bool del_item_from_sequence (string item_path);
        public static GLib.Quark error_quark ();
        public string get_node_parent (string path);
        public string get_node_path_portion (string path);
        public Gda.ServerOperationNodeType get_node_type (string path, Gda.ServerOperationNodeStatus? status);
        public Gda.ServerOperationType get_op_type ();
        [CCode (array_length = false, array_null_terminated = true)]
        public string[] get_root_nodes ();
        [CCode (array_length = false, array_null_terminated = true)]
        public string[] get_sequence_item_names (string path);
        public uint get_sequence_max_size (string path);
        public uint get_sequence_min_size (string path);
        public unowned string get_sequence_name (string path);
        public uint get_sequence_size (string path);
        [Version (since = "4.2.6")]
        public string get_sql_identifier_at_path (Gda.Connection? cnc, Gda.ServerProvider? prov, string path);
        [CCode (cname = "gda_server_operation_get_value_at_path")]
        [Version (since = "4.2.6")]
        public unowned GLib.Value? get_value_at (string path);
        public bool is_valid (string? xml_file) throws GLib.Error;
        public bool load_data_from_xml ([CCode (type = "xmlNodePtr")] Xml.Node* node) throws GLib.Error;
        public static unowned string op_type_to_string (Gda.ServerOperationType type);
        [Version (since = "4.2.3")]
        public bool perform_create_database (string? provider) throws GLib.Error;
        [Version (since = "4.2.3")]
        public bool perform_create_table () throws GLib.Error;
        [Version (since = "4.2.3")]
        public bool perform_drop_database (string? provider) throws GLib.Error;
        [Version (since = "4.2.3")]
        public bool perform_drop_table () throws GLib.Error;
        [Version (since = "4.2.3")]
        public static Gda.ServerOperation? prepare_create_database (string provider, string? db_name) throws GLib.Error;
        [Version (since = "4.2.3")]
        public static Gda.ServerOperation? prepare_create_table (Gda.Connection cnc, string table_name, ...) throws GLib.Error;
        [Version (since = "4.2.3")]
        public static Gda.ServerOperation? prepare_drop_database (string provider, string? db_name) throws GLib.Error;
        [Version (since = "4.2.3")]
        public static Gda.ServerOperation? prepare_drop_table (Gda.Connection cnc, string table_name) throws GLib.Error;
        [NoWrapper]
        public virtual void seq_item_added (string seq_path, int item_index);
        [NoWrapper]
        public virtual void seq_item_remove (string seq_path, int item_index);
        [CCode (cname = "gda_server_operation_set_value_at_path")]
        [Version (since = "4.2.6")]
        public bool set_value_at (string? value, string path) throws GLib.Error;
        [Version (since = "4.2")]
        public static Gda.ServerOperationType string_to_op_type (string str);
        [NoAccessorMethod]
        public Gda.Connection connection { owned get; construct; }
        public int op_type { get; construct; }
        [NoAccessorMethod]
        public Gda.ServerProvider provider { owned get; construct; }
        [NoAccessorMethod]
        public string spec_filename { construct; }
        public signal void sequence_item_added (string seq_path, int item_index);
        public signal void sequence_item_remove (string seq_path, int item_index);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_server_provider_get_type ()")]
    public abstract class ServerProvider : GLib.Object {
        [CCode (has_construct_function = false)]
        protected ServerProvider ();
        [NoWrapper]
        public virtual bool add_savepoint (Gda.Connection cnc, string name) throws GLib.Error;
        [NoWrapper]
        public virtual bool begin_transaction (Gda.Connection cnc, string name, Gda.TransactionIsolation level) throws GLib.Error;
        [NoWrapper]
        public virtual bool cancel (Gda.Connection cnc, uint task_id) throws GLib.Error;
        [NoWrapper]
        public virtual bool close_connection (Gda.Connection cnc);
        [NoWrapper]
        public virtual bool commit_transaction (Gda.Connection cnc, string name) throws GLib.Error;
        public virtual Gda.ServerOperation? create_operation (Gda.Connection? cnc, Gda.ServerOperationType type, Gda.Set? options) throws GLib.Error;
        public virtual Gda.SqlParser create_parser (Gda.Connection? cnc);
        [NoWrapper]
        public virtual bool delete_savepoint (Gda.Connection cnc, string name) throws GLib.Error;
        public static GLib.Quark error_quark ();
        public virtual string escape_string (Gda.Connection? cnc, string str);
        public string find_file (string inst_dir, string filename);
        public unowned Gda.DataHandler get_data_handler_dbms (Gda.Connection? cnc, string for_type);
        [Version (deprecated = true, deprecated_since = "5.2")]
        public unowned Gda.DataHandler get_data_handler_default (Gda.Connection? cnc, GLib.Type type, string dbms_type);
        public unowned Gda.DataHandler get_data_handler_g_type (Gda.Connection? cnc, GLib.Type for_type);
        [NoWrapper]
        public virtual unowned string get_database (Gda.Connection cnc);
        [NoWrapper]
        public virtual unowned string get_def_dbms_type (Gda.Connection cnc, GLib.Type g_type);
        public unowned string? get_default_dbms_type (Gda.Connection? cnc, GLib.Type type);
        public virtual unowned string get_name ();
        public virtual unowned string get_server_version (Gda.Connection cnc);
        public virtual unowned string get_version ();
        [NoWrapper]
        public virtual bool handle_async (Gda.Connection cnc) throws GLib.Error;
        public void handler_declare (Gda.DataHandler dh, Gda.Connection cnc, GLib.Type g_type, string dbms_type);
        public unowned Gda.DataHandler handler_find (Gda.Connection? cnc, GLib.Type g_type, string? dbms_type);
        [NoWrapper]
        public virtual string identifier_quote (Gda.Connection cnc, string id, bool for_meta_store, bool force_quotes);
        public unowned Gda.SqlParser internal_get_parser ();
        [NoWrapper]
        public virtual bool is_busy (Gda.Connection cnc) throws GLib.Error;
        public static string load_file_contents (string inst_dir, string data_dir, string filename);
        public bool perform_operation (Gda.Connection? cnc, Gda.ServerOperation op) throws GLib.Error;
        public bool perform_operation_default (Gda.Connection? cnc, Gda.ServerOperation op) throws GLib.Error;
        public virtual string? render_operation (Gda.Connection? cnc, Gda.ServerOperation op) throws GLib.Error;
        [NoWrapper]
        public virtual bool rollback_savepoint (Gda.Connection cnc, string name) throws GLib.Error;
        [NoWrapper]
        public virtual bool rollback_transaction (Gda.Connection cnc, string name) throws GLib.Error;
        [NoWrapper]
        public virtual bool statement_prepare (Gda.Connection cnc, Gda.Statement stmt) throws GLib.Error;
        public GLib.Value? string_to_value (Gda.Connection? cnc, string string, GLib.Type preferred_type, string? dbms_type);
        public virtual bool supports_feature (Gda.Connection? cnc, Gda.ConnectionFeature feature);
        public virtual bool supports_operation (Gda.Connection? cnc, Gda.ServerOperationType type, Gda.Set? options);
        public virtual string unescape_string (Gda.Connection? cnc, string str);
        public string value_to_sql_string (Gda.Connection? cnc, GLib.Value from);
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class ServerProviderInfo {
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_set_get_type ()")]
    public class Set : GLib.Object {
        public weak GLib.SList<Gda.SetGroup> groups_list;
        public weak GLib.SList<Gda.SetNode> nodes_list;
        public weak GLib.SList<Gda.SetSource> sources_list;
        [CCode (has_construct_function = false)]
        public Set (GLib.SList<Gda.Holder> holders);
        public bool add_holder (Gda.Holder holder);
        public Gda.Set copy ();
        public static GLib.Quark error_quark ();
        [CCode (has_construct_function = false)]
        public Set.from_spec_node ([CCode (type = "xmlNodePtr")] Xml.Node* xml_spec) throws GLib.Error;
        [CCode (has_construct_function = false)]
        public Set.from_spec_string (string xml_spec) throws GLib.Error;
        public unowned Gda.SetGroup get_group (Gda.Holder holder);
        public unowned Gda.Holder get_holder (string holder_id);
        public unowned GLib.Value? get_holder_value (string holder_id);
        public unowned Gda.SetNode get_node (Gda.Holder holder);
        [Version (since = "4.2")]
        public unowned Gda.Holder get_nth_holder (int pos);
        public unowned Gda.SetSource get_source (Gda.Holder holder);
        public unowned Gda.SetSource get_source_for_model (Gda.DataModel model);
        public bool is_valid () throws GLib.Error;
        public void merge_with_set (Gda.Set set_to_merge);
        [CCode (has_construct_function = false)]
        [Version (since = "4.2")]
        public Set.read_only (GLib.SList<Gda.Holder> holders);
        public void remove_holder (Gda.Holder holder);
        [Version (since = "4.2")]
        public void replace_source_model (Gda.SetSource source, Gda.DataModel model);
        [NoAccessorMethod]
        public string description { owned get; set; }
        [NoAccessorMethod]
        public void* holders { construct; }
        [NoAccessorMethod]
        public string id { owned get; set; }
        [NoAccessorMethod]
        public string name { owned get; set; }
        [NoAccessorMethod]
        [Version (since = "5.2.0")]
        public bool validate_changes { get; set; }
        public virtual signal void holder_attr_changed (Gda.Holder holder, string attr_name, GLib.Value attr_value);
        public virtual signal void holder_changed (Gda.Holder holder);
        [Version (since = "4.2")]
        public virtual signal void holder_type_set (Gda.Holder holder);
        public virtual signal void public_data_changed ();
        [Version (since = "4.2")]
        public virtual signal void source_model_changed (void* source);
        public virtual signal GLib.Error validate_holder_change (Gda.Holder holder, GLib.Value new_value);
        public virtual signal GLib.Error validate_set ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gda_set_group_get_type ()")]
    [Compact]
    public class SetGroup {
        public weak GLib.SList<Gda.SetNode> nodes;
        public weak Gda.SetSource nodes_source;
        [CCode (has_construct_function = false)]
        [Version (since = "5.2")]
        public SetGroup (Gda.SetNode node);
        [Version (since = "5.2")]
        public void add_node (Gda.SetNode node);
        [Version (since = "5.2")]
        public Gda.SetGroup copy ();
        [Version (since = "5.2")]
        public void free ();
        [Version (since = "5.2")]
        public int get_n_nodes ();
        [Version (since = "5.2")]
        public Gda.SetNode get_node ();
        [Version (since = "5.2")]
        public unowned GLib.SList<Gda.SetNode> get_nodes ();
        [Version (since = "5.2")]
        public Gda.SetSource get_source ();
        [Version (since = "5.2")]
        public void set_source (Gda.SetSource source);
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gda_set_node_get_type ()")]
    [Compact]
    public class SetNode {
        public weak Gda.Holder holder;
        public int source_column;
        public weak Gda.DataModel source_model;
        [CCode (has_construct_function = false)]
        [Version (since = "5.2")]
        public SetNode (Gda.Holder holder);
        [Version (since = "5.2")]
        public Gda.SetNode copy ();
        [Version (since = "5.2")]
        public void free ();
        [Version (since = "5.2")]
        public unowned Gda.DataModel get_data_model ();
        [Version (since = "5.2")]
        public unowned Gda.Holder get_holder ();
        [Version (since = "5.2")]
        public int get_source_column ();
        [Version (since = "5.2")]
        public void set_data_model (Gda.DataModel? model);
        [Version (since = "5.2")]
        public void set_holder (Gda.Holder holder);
        [Version (since = "5.2")]
        public void set_source_column (int column);
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gda_set_source_get_type ()")]
    [Compact]
    public class SetSource {
        public weak Gda.DataModel data_model;
        public weak GLib.SList<Gda.SetNode> nodes;
        [CCode (has_construct_function = false)]
        [Version (since = "5.2")]
        public SetSource (Gda.DataModel model);
        [Version (since = "5.2")]
        public void add_node (Gda.SetNode node);
        [Version (since = "5.2")]
        public Gda.SetSource copy ();
        [Version (since = "5.2")]
        public void free ();
        [Version (since = "5.2")]
        public unowned Gda.DataModel get_data_model ();
        [Version (since = "5.2")]
        public int get_n_nodes ();
        [Version (since = "5.2")]
        public unowned GLib.SList<Gda.SetNode> get_nodes ();
        [Version (since = "5.2")]
        public void set_data_model (Gda.DataModel model);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_short_get_type ()")]
    public class Short {
        [CCode (has_construct_function = false)]
        protected Short ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_sql_builder_get_type ()")]
    public class SqlBuilder : GLib.Object {
        [CCode (has_construct_function = false)]
        [Version (since = "4.2")]
        public SqlBuilder (Gda.SqlStatementType stmt_type);
        [Version (since = "4.2")]
        public Gda.SqlBuilderId add_case_v (Gda.SqlBuilderId test_expr, Gda.SqlBuilderId else_expr, [CCode (array_length_cname = "args_size", array_length_pos = 4.1)] Gda.SqlBuilderId[] when_array, [CCode (array_length_cname = "args_size", array_length_pos = 4.1)] Gda.SqlBuilderId[] then_array);
        [Version (since = "4.2")]
        public Gda.SqlBuilderId add_cond (Gda.SqlOperatorType op, Gda.SqlBuilderId op1, Gda.SqlBuilderId op2, Gda.SqlBuilderId op3);
        [Version (since = "4.2")]
        public Gda.SqlBuilderId add_cond_v (Gda.SqlOperatorType op, [CCode (array_length_cname = "op_ids_size", array_length_pos = 2.1)] Gda.SqlBuilderId[] op_ids);
        [Version (since = "4.2")]
        public Gda.SqlBuilderId add_expr_value (Gda.DataHandler? dh, GLib.Value? value);
        [Version (since = "4.2")]
        public Gda.SqlBuilderId add_field_id (string field_name, string? table_name);
        [Version (since = "4.2")]
        public void add_field_value_as_gvalue (string field_name, GLib.Value? value);
        [Version (since = "4.2")]
        public void add_field_value_id (Gda.SqlBuilderId field_id, Gda.SqlBuilderId value_id);
        [Version (since = "4.2")]
        public Gda.SqlBuilderId add_function_v (string func_name, [CCode (array_length_cname = "args_size", array_length_pos = 2.1)] Gda.SqlBuilderId[] args);
        [Version (since = "4.2")]
        public Gda.SqlBuilderId add_id (string str);
        [Version (since = "4.2")]
        public Gda.SqlBuilderId add_param (string param_name, GLib.Type type, bool nullok);
        [Version (since = "4.2")]
        public void compound_add_sub_select_from_builder (Gda.SqlBuilder subselect);
        [Version (since = "4.2")]
        public void compound_set_type (Gda.SqlStatementCompoundType compound_type);
        public static GLib.Quark error_quark ();
        [Version (since = "4.2")]
        public Gda.Statement get_statement () throws GLib.Error;
        [Version (since = "4.2")]
        public Gda.SqlBuilderId import_expression_from_builder (Gda.SqlBuilder query, Gda.SqlBuilderId expr_id);
        [Version (since = "4.2")]
        public void join_add_field (Gda.SqlBuilderId join_id, string field_name);
        [Version (since = "4.2")]
        public Gda.SqlBuilderId select_add_field (string field_name, string? table_name, string? alias);
        [Version (since = "4.2")]
        public Gda.SqlBuilderId select_add_target (string table_name, string? alias);
        [Version (since = "4.2")]
        public Gda.SqlBuilderId select_add_target_id (Gda.SqlBuilderId table_id, string? alias);
        [Version (since = "4.2")]
        public void select_group_by (Gda.SqlBuilderId expr_id);
        [Version (since = "4.2")]
        public void select_order_by (Gda.SqlBuilderId expr_id, bool asc, string? collation_name);
        [Version (since = "4.2")]
        public void select_set_distinct (bool distinct, Gda.SqlBuilderId expr_id);
        [Version (since = "4.2")]
        public void select_set_having (Gda.SqlBuilderId cond_id);
        [Version (since = "4.2")]
        public void select_set_limit (Gda.SqlBuilderId limit_count_expr_id, Gda.SqlBuilderId limit_offset_expr_id);
        [Version (since = "4.2")]
        public void set_table (string table_name);
        [Version (since = "4.2")]
        public void set_where (Gda.SqlBuilderId cond_id);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_sql_parser_get_type ()")]
    public class SqlParser : GLib.Object, Gda.Lockable {
        [CCode (has_construct_function = false)]
        public SqlParser ();
        public static GLib.Quark error_quark ();
        public Gda.Batch? parse_file_as_batch (string filename) throws GLib.Error;
        public Gda.Statement? parse_string (string sql, out string remain) throws GLib.Error;
        public Gda.Batch? parse_string_as_batch (string sql, out string remain) throws GLib.Error;
        public void set_overflow_error ();
        public void set_syntax_error ();
        [NoAccessorMethod]
        public int column_error { get; }
        [NoAccessorMethod]
        public int line_error { get; }
        [NoAccessorMethod]
        public int mode { get; set; }
        [NoAccessorMethod]
        public int tokenizer_flavour { get; set; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class SqlStatement {
        public void compound_set_type (Gda.SqlStatementCompoundType type);
        public void compound_take_stmt (Gda.SqlStatement s);
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class SqlStatementDelete {
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class SqlStatementInsert {
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class SqlStatementSelect {
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class SqlStatementTransaction {
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class SqlStatementUnknown {
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class SqlStatementUpdate {
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_statement_get_type ()")]
    public class Statement : GLib.Object {
        [CCode (has_construct_function = false)]
        public Statement ();
        public bool check_structure () throws GLib.Error;
        public bool check_validity (Gda.Connection? cnc) throws GLib.Error;
        public Gda.Statement copy ();
        public static GLib.Quark error_quark ();
        public bool get_parameters (out Gda.Set out_params) throws GLib.Error;
        public Gda.SqlStatementType get_statement_type ();
        public bool is_useless ();
        public bool normalize (Gda.Connection cnc) throws GLib.Error;
        public string serialize ();
        public string to_sql_extended (Gda.Connection? cnc, Gda.Set? @params, Gda.StatementSqlFlag flags, out GLib.SList<weak Gda.Holder> params_used) throws GLib.Error;
        public string to_sql_real (Gda.SqlRenderingContext context) throws GLib.Error;
        [NoAccessorMethod]
        public void* structure { get; set; }
        public virtual signal void checked (Gda.Connection cnc, bool checked);
        public virtual signal void reset ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_thread_wrapper_get_type ()")]
    public class ThreadWrapper : GLib.Object {
        [CCode (has_construct_function = false)]
        [Version (since = "4.2")]
        public ThreadWrapper ();
        [Version (since = "4.2")]
        public bool cancel (uint id);
        [Version (since = "4.2")]
        public ulong connect_raw (void* instance, string sig_name, bool private_thread, bool private_job, Gda.ThreadWrapperCallback callback);
        [Version (since = "4.2")]
        public void disconnect (ulong id);
        public static GLib.Quark error_quark ();
        [Version (since = "4.2")]
        public uint execute ([CCode (destroy_notify_pos = 2.1)] owned Gda.ThreadWrapperFunc func, void* arg) throws GLib.Error;
        [Version (since = "4.2")]
        public uint execute_void ([CCode (destroy_notify_pos = 2.1)] owned Gda.ThreadWrapperVoidFunc func, void* arg) throws GLib.Error;
        [Version (since = "4.2")]
        public void* fetch_result (bool may_lock, uint exp_id) throws GLib.Error;
        [Version (since = "4.2.9")]
        public unowned GLib.IOChannel get_io_channel ();
        [Version (since = "4.2")]
        public int get_waiting_size ();
        [Version (since = "4.2")]
        public void iterate (bool may_block);
        [Version (since = "4.2")]
        public void steal_signal (ulong id);
        [Version (since = "4.2.9")]
        public void unset_io_channel ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gda_time_get_type ()")]
    [Compact]
    public class Time {
        public ulong fraction;
        public ushort hour;
        public ushort minute;
        public ushort second;
        public long timezone;
        [Version (since = "5.2")]
        public void change_timezone (long ntz);
        public static void* copy (void* boxed);
        public static void free (void* boxed);
        [Version (since = "4.2")]
        public bool valid ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gda_timestamp_get_type ()")]
    [Compact]
    public class Timestamp {
        public ushort day;
        public ulong fraction;
        public ushort hour;
        public ushort minute;
        public ushort month;
        public ushort second;
        public long timezone;
        public short year;
        [Version (since = "5.2")]
        public void change_timezone (long ntz);
        public static void* copy (void* boxed);
        public static void free (void* boxed);
        [Version (since = "4.2")]
        public bool valid ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_transaction_status_get_type ()")]
    public class TransactionStatus : GLib.Object {
        public weak GLib.List<Gda.TransactionStatusEvent?> events;
        public Gda.TransactionIsolation isolation_level;
        public weak string name;
        public Gda.TransactionStatusState state;
        [CCode (has_construct_function = false)]
        public TransactionStatus (string name);
        public Gda.TransactionStatus? find (string str, Gda.TransactionStatusEvent destev);
        public Gda.TransactionStatus? find_current (Gda.TransactionStatusEvent destev, bool unnamed_only);
        public void free_events (Gda.TransactionStatusEvent event, bool free_after);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_tree_get_type ()")]
    public class Tree : GLib.Object {
        [CCode (has_construct_function = false)]
        [Version (since = "4.2")]
        public Tree ();
        [Version (since = "4.2")]
        public void add_manager (Gda.TreeManager manager);
        [Version (since = "4.2")]
        public void clean ();
        [Version (since = "4.2")]
        public void dump (Gda.TreeNode? node, void* stream);
        public static GLib.Quark error_quark ();
        [Version (since = "4.2")]
        public unowned Gda.TreeNode? get_node (string tree_path, bool use_names);
        [Version (since = "4.2")]
        public unowned Gda.TreeManager get_node_manager (Gda.TreeNode node);
        [Version (since = "4.2")]
        public string get_node_path (Gda.TreeNode node);
        [Version (since = "4.2")]
        public GLib.SList<weak Gda.TreeNode> get_nodes_in_path (string? tree_path, bool use_names);
        [Version (since = "4.2")]
        public void set_attribute (string attribute, GLib.Value value, GLib.DestroyNotify destroy);
        [Version (since = "4.2")]
        public bool update_all () throws GLib.Error;
        [Version (since = "4.2.8")]
        public bool update_children (Gda.TreeNode? node) throws GLib.Error;
        [Version (since = "4.2")]
        public bool update_part (Gda.TreeNode node) throws GLib.Error;
        [NoAccessorMethod]
        public bool is_list { get; }
        [Version (since = "4.2")]
        public virtual signal void node_changed (Gda.TreeNode node);
        [Version (since = "4.2")]
        public virtual signal void node_deleted (string node_path);
        [Version (since = "4.2")]
        public virtual signal void node_has_child_toggled (Gda.TreeNode node);
        [Version (since = "4.2")]
        public virtual signal void node_inserted (Gda.TreeNode node);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_tree_manager_get_type ()")]
    public class TreeManager : GLib.Object {
        [CCode (has_construct_function = false)]
        protected TreeManager ();
        [Version (since = "4.2")]
        public void add_manager (Gda.TreeManager sub);
        [Version (since = "4.2")]
        public void add_new_node_attribute (string attribute, GLib.Value? value);
        [Version (since = "4.2")]
        public Gda.TreeNode create_node (Gda.TreeNode? parent, string? name);
        public static GLib.Quark error_quark ();
        [Version (since = "4.2")]
        public unowned GLib.SList<Gda.TreeManager> get_managers ();
        [NoAccessorMethod]
        public void* func { get; set construct; }
        [NoAccessorMethod]
        public bool recursive { get; set construct; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_tree_mgr_columns_get_type ()")]
    public class TreeMgrColumns : Gda.TreeManager {
        [CCode (has_construct_function = false, type = "GdaTreeManager*")]
        [Version (since = "4.2")]
        public TreeMgrColumns (Gda.Connection cnc, string schema, string table_name);
        [NoAccessorMethod]
        public Gda.Connection connection { owned get; construct; }
        [NoAccessorMethod]
        [Version (since = "4.2.4")]
        public Gda.MetaStore meta_store { owned get; construct; }
        [NoAccessorMethod]
        public string schema { construct; }
        [NoAccessorMethod]
        public string table_name { construct; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class TreeMgrColumnsPriv {
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_tree_mgr_label_get_type ()")]
    public class TreeMgrLabel : Gda.TreeManager {
        [CCode (has_construct_function = false, type = "GdaTreeManager*")]
        [Version (since = "4.2")]
        public TreeMgrLabel (string label);
        [NoAccessorMethod]
        public string label { construct; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class TreeMgrLabelPriv {
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_tree_mgr_schemas_get_type ()")]
    public class TreeMgrSchemas : Gda.TreeManager {
        [CCode (has_construct_function = false, type = "GdaTreeManager*")]
        [Version (since = "4.2")]
        public TreeMgrSchemas (Gda.Connection cnc);
        [NoAccessorMethod]
        public Gda.Connection connection { owned get; construct; }
        [NoAccessorMethod]
        [Version (since = "4.2.4")]
        public Gda.MetaStore meta_store { owned get; construct; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class TreeMgrSchemasPriv {
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_tree_mgr_select_get_type ()")]
    public class TreeMgrSelect : Gda.TreeManager {
        [CCode (has_construct_function = false, type = "GdaTreeManager*")]
        [Version (since = "4.2")]
        public TreeMgrSelect (Gda.Connection cnc, Gda.Statement stmt, Gda.Set @params);
        [NoAccessorMethod]
        public Gda.Connection connection { owned get; construct; }
        [NoAccessorMethod]
        public Gda.Set @params { owned get; construct; }
        [NoAccessorMethod]
        public Gda.Statement statement { owned get; construct; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class TreeMgrSelectPriv {
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_tree_mgr_tables_get_type ()")]
    public class TreeMgrTables : Gda.TreeManager {
        [CCode (has_construct_function = false, type = "GdaTreeManager*")]
        [Version (since = "4.2")]
        public TreeMgrTables (Gda.Connection cnc, string? schema);
        [NoAccessorMethod]
        public Gda.Connection connection { owned get; construct; }
        [NoAccessorMethod]
        [Version (since = "4.2.4")]
        public Gda.MetaStore meta_store { owned get; construct; }
        [NoAccessorMethod]
        public string schema { construct; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    [Compact]
    public class TreeMgrTablesPriv {
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_tree_node_get_type ()")]
    public class TreeNode : GLib.Object {
        [CCode (has_construct_function = false)]
        [Version (since = "4.2")]
        public TreeNode (string? name);
        [NoWrapper]
        public virtual void dump_children (string prefix, GLib.StringBuilder in_string);
        [NoWrapper]
        public virtual string dump_header ();
        public static GLib.Quark error_quark ();
        [Version (since = "4.2")]
        public unowned GLib.Value? fetch_attribute (string attribute);
        [Version (since = "4.2")]
        public unowned Gda.TreeNode get_child_index (int index);
        [Version (since = "4.2")]
        public unowned Gda.TreeNode get_child_name (string name);
        [Version (since = "4.2")]
        public GLib.SList<weak Gda.TreeNode> get_children ();
        [Version (since = "4.2")]
        public unowned GLib.Value? get_node_attribute (string attribute);
        [Version (since = "4.2")]
        public unowned Gda.TreeNode get_parent ();
        [Version (since = "4.2")]
        public void set_node_attribute (string attribute, GLib.Value? value, GLib.DestroyNotify destroy);
        [NoAccessorMethod]
        public string name { owned get; set; }
        [Version (since = "4.2")]
        public virtual signal void node_changed (Gda.TreeNode node);
        [Version (since = "4.2")]
        public virtual signal void node_deleted (string relative_path);
        [Version (since = "4.2")]
        public virtual signal void node_has_child_toggled (Gda.TreeNode node);
        [Version (since = "4.2")]
        public virtual signal void node_inserted (Gda.TreeNode node);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_ushort_get_type ()")]
    public class UShort {
        [CCode (has_construct_function = false)]
        protected UShort ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_xa_transaction_get_type ()")]
    public class XaTransaction : GLib.Object {
        [CCode (has_construct_function = false)]
        public XaTransaction (uint32 format, string global_transaction_id);
        public bool begin () throws GLib.Error;
        public bool commit (out GLib.SList<Gda.Connection> cnc_to_recover) throws GLib.Error;
        public bool commit_recovered (out GLib.SList<Gda.Connection> cnc_to_recover) throws GLib.Error;
        public static GLib.Quark error_quark ();
        public bool register_connection (Gda.Connection cnc, string branch) throws GLib.Error;
        public bool rollback () throws GLib.Error;
        public void unregister_connection (Gda.Connection cnc);
        [NoAccessorMethod]
        public uint format_id { get; construct; }
        [NoAccessorMethod]
        public string transaction_id { owned get; construct; }
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_data_handler_get_type ()")]
    public interface DataHandler : GLib.Object {
        public abstract bool accepts_g_type (GLib.Type type);
        [Version (since = "4.2.3")]
        public static unowned Gda.DataHandler get_default (GLib.Type for_type);
        public abstract unowned string get_descr ();
        public abstract GLib.Value? get_sane_init_value (GLib.Type type);
        public abstract string get_sql_from_value (GLib.Value? value);
        public abstract string get_str_from_value (GLib.Value? value);
        public abstract GLib.Value? get_value_from_sql (string? sql, GLib.Type type);
        public abstract GLib.Value? get_value_from_str (string? str, GLib.Type type);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_data_model_get_type ()")]
    public interface DataModel : GLib.Object {
        public bool add_data_from_xml_node ([CCode (type = "xmlNodePtr")] Xml.Node* node) throws GLib.Error;
        [CCode (vfunc_name = "i_append_row")]
        public abstract int append_row () throws GLib.Error;
        [CCode (vfunc_name = "i_append_values")]
        public abstract int append_values (GLib.List<GLib.Value?>? values) throws GLib.Error;
        public Gda.DataModelArray? array_copy_model () throws GLib.Error;
        [Version (since = "5.2.0")]
        public Gda.DataModelArray? array_copy_model_ext ([CCode (array_length_cname = "ncols", array_length_pos = 0.5)] int[] cols) throws GLib.Error;
        [CCode (vfunc_name = "i_create_iter")]
        public abstract Gda.DataModelIter create_iter ();
        [CCode (vfunc_name = "i_describe_column")]
        public abstract unowned Gda.Column? describe_column (int col);
        public void dump (void* to_stream);
        public string dump_as_string ();
        public static GLib.Quark error_quark ();
        public bool export_to_file (Gda.DataModelIOFormat format, string file, [CCode (array_length_cname = "nb_cols", array_length_pos = 3.5)] int[]? cols, [CCode (array_length_cname = "nb_rows", array_length_pos = 4.5)] int[]? rows, Gda.Set options) throws GLib.Error;
        public string export_to_string (Gda.DataModelIOFormat format, [CCode (array_length_cname = "nb_cols", array_length_pos = 2.5)] int[]? cols, [CCode (array_length_cname = "nb_rows", array_length_pos = 3.5)] int[]? rows, Gda.Set options);
        public void freeze ();
        [CCode (vfunc_name = "i_get_access_flags")]
        public abstract Gda.DataModelAccessFlags get_access_flags ();
        [CCode (vfunc_name = "i_get_attributes_at")]
        public abstract Gda.ValueAttribute get_attributes_at (int col, int row);
        public int get_column_index (string name);
        [Version (since = "3.2")]
        public unowned string get_column_name (int col);
        public unowned string get_column_title (int col);
        [CCode (array_length = false, array_null_terminated = true, vfunc_name = "i_get_exceptions")]
        [Version (since = "4.2.6")]
        public abstract unowned GLib.Error[] get_exceptions ();
        [CCode (vfunc_name = "i_get_n_columns")]
        public abstract int get_n_columns ();
        [CCode (vfunc_name = "i_get_n_rows")]
        public abstract int get_n_rows ();
        [CCode (vfunc_name = "i_get_notify")]
        public abstract bool get_notify ();
        [CCode (vfunc_name = "i_find_row")]
        public abstract int get_row_from_values (GLib.SList<GLib.Value?> values, [CCode (array_length = false)] int[] cols_index);
        public unowned GLib.Value? get_typed_value_at (int col, int row, GLib.Type expected_type, bool nullok) throws GLib.Error;
        [CCode (vfunc_name = "i_get_value_at")]
        public abstract unowned GLib.Value? get_value_at (int col, int row) throws GLib.Error;
        public bool import_from_file (string file, GLib.HashTable<int,int>? cols_trans, Gda.Set options) throws GLib.Error;
        public bool import_from_model (Gda.DataModel from, bool overwrite, GLib.HashTable<int,int>? cols_trans) throws GLib.Error;
        public bool import_from_string (string string, GLib.HashTable<int,int>? cols_trans, Gda.Set options) throws GLib.Error;
        [CCode (vfunc_name = "i_iter_at_row")]
        [Version (deprecated = true, deprecated_since = "5.2")]
        public abstract bool iter_at_row (Gda.DataModelIter iter, int row);
        [CCode (vfunc_name = "i_iter_next")]
        [Version (deprecated = true, deprecated_since = "5.2")]
        public abstract bool iter_next (Gda.DataModelIter iter);
        [CCode (vfunc_name = "i_iter_prev")]
        [Version (deprecated = true, deprecated_since = "5.2")]
        public abstract bool iter_prev (Gda.DataModelIter iter);
        [CCode (vfunc_name = "i_iter_set_value")]
        [Version (deprecated = true, deprecated_since = "5.2")]
        public abstract bool iter_set_value (Gda.DataModelIter iter, int col, GLib.Value value) throws GLib.Error;
        [CCode (vfunc_name = "i_remove_row")]
        public abstract bool remove_row (int row) throws GLib.Error;
        [CCode (vfunc_name = "i_send_hint")]
        public abstract void send_hint (Gda.DataModelHint hint, GLib.Value? hint_value);
        [Version (since = "3.2")]
        public void set_column_name (int col, string name);
        public void set_column_title (int col, string title);
        [CCode (vfunc_name = "i_set_notify")]
        [Version (deprecated = true, deprecated_since = "5.2")]
        public abstract void set_notify (bool do_notify_changes);
        [CCode (vfunc_name = "i_set_value_at")]
        public abstract bool set_value_at (int col, int row, GLib.Value value) throws GLib.Error;
        [CCode (vfunc_name = "i_set_values")]
        public abstract bool set_values (int row, GLib.List<GLib.Value?>? values) throws GLib.Error;
        public void thaw ();
        public virtual signal void access_changed ();
        public virtual signal void changed ();
        [HasEmitter]
        public virtual signal void reset ();
        [HasEmitter]
        public virtual signal void row_inserted (int row);
        [HasEmitter]
        public virtual signal void row_removed (int row);
        [HasEmitter]
        public virtual signal void row_updated (int row);
    }
    [CCode (cheader_filename = "libgda/libgda.h", type_id = "gda_lockable_get_type ()")]
    public interface Lockable : GLib.Object {
        [NoWrapper]
        public abstract void i_lock ();
        [NoWrapper]
        public abstract bool i_trylock ();
        [NoWrapper]
        public abstract void i_unlock ();
        public void @lock ();
        public bool trylock ();
        public void @unlock ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct Diff {
        public Gda.DiffType type;
        public int old_row;
        public int new_row;
        public weak GLib.HashTable<void*,void*> values;
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct MetaDbObject {
        public Gda.MetaDbObjectType obj_type;
        public bool outdated;
        public weak string obj_catalog;
        public weak string obj_schema;
        public weak string obj_name;
        public weak string obj_short_name;
        public weak string obj_full_name;
        public weak string obj_owner;
        public weak GLib.SList<Gda.MetaDbObject?> depend_list;
        [CCode (cname = "extra.meta_table")]
        public Gda.MetaTable extra_meta_table;
        [CCode (cname = "extra.meta_view")]
        public Gda.MetaView extra_meta_view;
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct MetaStoreChange {
        public Gda.MetaStoreChangeType c_type;
        public weak string table_name;
        public weak GLib.HashTable<string,GLib.Value?> keys;
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct MetaTable {
        public weak GLib.SList<Gda.MetaTableColumn?> columns;
        public int pk_cols_array;
        public int pk_cols_nb;
        public weak GLib.SList<Gda.MetaTableForeignKey?> reverse_fk_list;
        public weak GLib.SList<Gda.MetaTableForeignKey?> fk_list;
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct MetaTableColumn {
        public weak string column_name;
        public weak string column_type;
        public GLib.Type gtype;
        public bool pkey;
        public bool nullok;
        public weak string default_value;
        public void foreach_attribute (Gda.AttributesManagerFunc func);
        public unowned GLib.Value? get_attribute (string attribute);
        public void set_attribute (string attribute, GLib.Value? value, GLib.DestroyNotify? destroy);
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct MetaTableForeignKey {
        public Gda.MetaDbObject meta_table;
        public Gda.MetaDbObject depend_on;
        public int cols_nb;
        public int fk_cols_array;
        public weak string fk_names_array;
        public int ref_pk_cols_array;
        public weak string ref_pk_names_array;
        public weak string fk_name;
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct MetaView {
        public Gda.MetaTable table;
        public weak string view_def;
        public bool is_updatable;
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct Mutex : GLib.RecMutex {
        public void free ();
        public void @lock ();
        public bool trylock ();
        public void @unlock ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct ProviderInfo {
        public weak string id;
        public weak string location;
        public weak string description;
        public weak Gda.Set dsn_params;
        public weak Gda.Set auth_params;
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct ServerOperationNode {
        public Gda.ServerOperationNodeType type;
        public Gda.ServerOperationNodeStatus status;
        public weak Gda.Set plist;
        public weak Gda.DataModel model;
        public weak Gda.Column column;
        public weak Gda.Holder param;
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct ServerProviderHandlerInfo {
        public weak Gda.Connection cnc;
        public GLib.Type g_type;
        public weak string dbms_type;
    }
    [CCode (cheader_filename = "libgda/libgda.h")]
    [SimpleType]
    public struct SqlBuilderId : uint {
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct SqlParserIface {
        public weak Gda.SqlParser parser;
        public weak Gda.SqlStatement parsed_statement;
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct SqlRenderingContext {
        public Gda.StatementSqlFlag flags;
        public weak Gda.Set @params;
        public weak GLib.SList<Gda.Holder> params_used;
        public weak Gda.ServerProvider provider;
        public weak Gda.Connection cnc;
        public weak Gda.SqlRenderingValue render_value;
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct ThreadNotification {
        public Gda.ThreadNotificationType type;
        public uint job_id;
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct TransactionStatusEvent {
        public weak Gda.TransactionStatus trans;
        public Gda.TransactionStatusEventType type;
        public weak Gda.ConnectionEvent conn_event;
        [CCode (cname = "pl.svp_name")]
        public weak string pl_svp_name;
        [CCode (cname = "pl.sql")]
        public weak string pl_sql;
        [CCode (cname = "pl.sub_trans")]
        public weak Gda.TransactionStatus pl_sub_trans;
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_type_id = false)]
    public struct XaTransactionId {
        public uint32 format;
        public ushort gtrid_length;
        public ushort bqual_length;
        [CCode (array_length = false)]
        public weak char data[128];
        public string to_string ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_BATCH_CONFLICTING_PARAMETER_", has_type_id = false)]
    public enum BatchError {
        [CCode (cname = "GDA_BATCH_CONFLICTING_PARAMETER_ERROR")]
        BATCH_CONFLICTING_PARAMETER_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_CONFIG_", has_type_id = false)]
    public enum ConfigError {
        DSN_NOT_FOUND_ERROR,
        PERMISSION_ERROR,
        PROVIDER_NOT_FOUND_ERROR,
        PROVIDER_CREATION_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_CONNECTION_", has_type_id = false)]
    public enum ConnectionError {
        DSN_NOT_FOUND_ERROR,
        PROVIDER_NOT_FOUND_ERROR,
        PROVIDER_ERROR,
        NO_CNC_SPEC_ERROR,
        NO_PROVIDER_SPEC_ERROR,
        OPEN_ERROR,
        STATEMENT_TYPE_ERROR,
        CANT_LOCK_ERROR,
        TASK_NOT_FOUND_ERROR,
        UNSUPPORTED_THREADS_ERROR,
        CLOSED_ERROR,
        META_DATA_CONTEXT_ERROR,
        UNSUPPORTED_ASYNC_EXEC_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_CONNECTION_EVENT_CODE_", has_type_id = false)]
    public enum ConnectionEventCode {
        CONSTRAINT_VIOLATION,
        RESTRICT_VIOLATION,
        NOT_NULL_VIOLATION,
        FOREIGN_KEY_VIOLATION,
        UNIQUE_VIOLATION,
        CHECK_VIOLATION,
        INSUFFICIENT_PRIVILEGES,
        UNDEFINED_COLUMN,
        UNDEFINED_FUNCTION,
        UNDEFINED_TABLE,
        DUPLICATE_COLUMN,
        DUPLICATE_DATABASE,
        DUPLICATE_FUNCTION,
        DUPLICATE_SCHEMA,
        DUPLICATE_TABLE,
        DUPLICATE_ALIAS,
        DUPLICATE_OBJECT,
        SYNTAX_ERROR,
        UNKNOWN
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_CONNECTION_EVENT_", has_type_id = false)]
    public enum ConnectionEventType {
        NOTICE,
        WARNING,
        ERROR,
        COMMAND
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_CONNECTION_FEATURE_", has_type_id = false)]
    public enum ConnectionFeature {
        AGGREGATES,
        BLOBS,
        INDEXES,
        INHERITANCE,
        NAMESPACES,
        PROCEDURES,
        SEQUENCES,
        SQL,
        TRANSACTIONS,
        SAVEPOINTS,
        SAVEPOINTS_REMOVE,
        TRIGGERS,
        UPDATABLE_CURSOR,
        USERS,
        VIEWS,
        XA_TRANSACTIONS,
        MULTI_THREADING,
        ASYNC_EXEC,
        LAST
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_CONNECTION_META_", has_type_id = false)]
    public enum ConnectionMetaType {
        NAMESPACES,
        TYPES,
        TABLES,
        VIEWS,
        FIELDS,
        INDEXES
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_CONNECTION_OPTIONS_", has_type_id = false)]
    [Flags]
    public enum ConnectionOptions {
        NONE,
        READ_ONLY,
        SQL_IDENTIFIERS_CASE_SENSITIVE,
        THREAD_SAFE,
        THREAD_ISOLATED,
        AUTO_META_DATA
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_DATA_COMPARATOR_", has_type_id = false)]
    public enum DataComparatorError {
        MISSING_DATA_MODEL_ERROR,
        COLUMN_TYPES_MISMATCH_ERROR,
        MODEL_ACCESS_ERROR,
        USER_CANCELLED_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_DATA_MODEL_ACCESS_", has_type_id = false)]
    [Flags]
    public enum DataModelAccessFlags {
        RANDOM,
        CURSOR_FORWARD,
        CURSOR_BACKWARD,
        CURSOR,
        INSERT,
        UPDATE,
        DELETE,
        WRITE
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_DATA_MODEL_HINT_", has_type_id = false)]
    public enum DataModelHint {
        START_BATCH_UPDATE,
        END_BATCH_UPDATE,
        REFRESH
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_DATA_MODEL_IO_", has_type_id = false)]
    public enum DataModelIOFormat {
        DATA_ARRAY_XML,
        TEXT_SEPARATED,
        TEXT_TABLE
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_DATA_MODEL_ITER_COLUMN_OUT_OF_RANGE_", has_type_id = false)]
    public enum DataModelIterError {
        [CCode (cname = "GDA_DATA_MODEL_ITER_COLUMN_OUT_OF_RANGE_ERROR")]
        DATA_MODEL_ITER_COLUMN_OUT_OF_RANGE_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_DATA_PIVOT_", has_type_id = false)]
    public enum DataPivotAggregate {
        AVG,
        COUNT,
        MAX,
        MIN,
        SUM
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_DATA_PIVOT_", has_type_id = false)]
    public enum DataPivotError {
        INTERNAL_ERROR,
        SOURCE_MODEL_ERROR,
        FIELD_FORMAT_ERROR,
        USAGE_ERROR,
        OVERFLOW_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_DATA_PIVOT_FIELD_", has_type_id = false)]
    public enum DataPivotFieldType {
        ROW,
        COLUMN
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_DATA_PROXY_", has_type_id = false)]
    public enum DataProxyError {
        COMMIT_ERROR,
        COMMIT_CANCELLED,
        READ_ONLY_VALUE,
        READ_ONLY_ROW,
        FILTER_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_DATA_SELECT_COND_", has_type_id = false)]
    public enum DataSelectConditionType {
        PK,
        ALL_COLUMNS
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_DATA_SELECT_", has_type_id = false)]
    public enum DataSelectError {
        MODIFICATION_STATEMENT_ERROR,
        MISSING_MODIFICATION_STATEMENT_ERROR,
        CONNECTION_ERROR,
        ACCESS_ERROR,
        SQL_ERROR,
        SAFETY_LOCKED_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_DIFF_", has_type_id = false)]
    public enum DiffType {
        ADD_ROW,
        REMOVE_ROW,
        MODIFY_ROW
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_HOLDER_", has_type_id = false)]
    public enum HolderError {
        STRING_CONVERSION_ERROR,
        VALUE_TYPE_ERROR,
        VALUE_NULL_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_META_DB_", has_type_id = false)]
    public enum MetaDbObjectType {
        UNKNOWN,
        TABLE,
        VIEW
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_META_FOREIGN_KEY_", has_type_id = false)]
    public enum MetaForeignKeyPolicy {
        UNKNOWN,
        NONE,
        NO_ACTION,
        RESTRICT,
        CASCADE,
        SET_NULL,
        SET_DEFAULT
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_META_GRAPH_", has_type_id = false)]
    [Flags]
    public enum MetaGraphInfo {
        [CCode (cname = "GDA_META_GRAPH_COLUMNS")]
        META_GRAPH_COLUMNS
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_META_SORT_", has_type_id = false)]
    public enum MetaSortType {
        ALHAPETICAL,
        DEPENDENCIES
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_META_STORE_", has_type_id = false)]
    public enum MetaStoreChangeType {
        ADD,
        REMOVE,
        MODIFY
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_META_STORE_", has_type_id = false)]
    public enum MetaStoreError {
        INCORRECT_SCHEMA_ERROR,
        UNSUPPORTED_PROVIDER_ERROR,
        INTERNAL_ERROR,
        META_CONTEXT_ERROR,
        MODIFY_CONTENTS_ERROR,
        EXTRACT_SQL_ERROR,
        ATTRIBUTE_NOT_FOUND_ERROR,
        ATTRIBUTE_ERROR,
        SCHEMA_OBJECT_NOT_FOUND_ERROR,
        SCHEMA_OBJECT_CONFLICT_ERROR,
        SCHEMA_OBJECT_DESCR_ERROR,
        TRANSACTION_ALREADY_STARTED_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_META_STRUCT_", has_type_id = false)]
    public enum MetaStructError {
        UNKNOWN_OBJECT_ERROR,
        DUPLICATE_OBJECT_ERROR,
        INCOHERENCE_ERROR,
        XML_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_META_STRUCT_FEATURE_", has_type_id = false)]
    [Flags]
    public enum MetaStructFeature {
        NONE,
        FOREIGN_KEYS,
        VIEW_DEPENDENCIES,
        ALL
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SERVER_OPERATION_CREATE_TABLE_", has_type_id = false)]
    [Flags]
    public enum ServerOperationCreateTableFlag {
        NOTHING_FLAG,
        PKEY_FLAG,
        NOT_NULL_FLAG,
        UNIQUE_FLAG,
        AUTOINC_FLAG,
        FKEY_FLAG,
        PKEY_AUTOINC_FLAG
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SERVER_OPERATION_", has_type_id = false)]
    public enum ServerOperationError {
        OBJECT_NAME_ERROR,
        INCORRECT_VALUE_ERROR,
        XML_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SERVER_OPERATION_STATUS_", has_type_id = false)]
    public enum ServerOperationNodeStatus {
        OPTIONAL,
        REQUIRED,
        UNKNOWN
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SERVER_OPERATION_NODE_", has_type_id = false)]
    public enum ServerOperationNodeType {
        PARAMLIST,
        DATA_MODEL,
        PARAM,
        SEQUENCE,
        SEQUENCE_ITEM,
        DATA_MODEL_COLUMN,
        UNKNOWN
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SERVER_OPERATION_", has_type_id = false)]
    public enum ServerOperationType {
        CREATE_DB,
        DROP_DB,
        CREATE_TABLE,
        DROP_TABLE,
        RENAME_TABLE,
        ADD_COLUMN,
        DROP_COLUMN,
        CREATE_INDEX,
        DROP_INDEX,
        CREATE_VIEW,
        DROP_VIEW,
        COMMENT_TABLE,
        COMMENT_COLUMN,
        CREATE_USER,
        ALTER_USER,
        DROP_USER,
        LAST
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SERVER_PROVIDER_", has_type_id = false)]
    public enum ServerProviderError {
        METHOD_NON_IMPLEMENTED_ERROR,
        PREPARE_STMT_ERROR,
        EMPTY_STMT_ERROR,
        MISSING_PARAM_ERROR,
        STATEMENT_EXEC_ERROR,
        OPERATION_ERROR,
        INTERNAL_ERROR,
        BUSY_ERROR,
        NON_SUPPORTED_ERROR,
        SERVER_VERSION_ERROR,
        DATA_ERROR,
        DEFAULT_VALUE_HANDLING_ERROR,
        MISUSE_ERROR,
        FILE_NOT_FOUND_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SET_", has_type_id = false)]
    public enum SetError {
        XML_SPEC_ERROR,
        HOLDER_NOT_FOUND_ERROR,
        INVALID_ERROR,
        READ_ONLY_ERROR,
        IMPLEMENTATION_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SQL_BUILDER_", has_type_id = false)]
    public enum SqlBuilderError {
        WRONG_TYPE_ERROR,
        MISUSE_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SQL_IDENTIFIERS_", has_type_id = false)]
    [Flags]
    public enum SqlIdentifierStyle {
        LOWER_CASE,
        UPPER_CASE
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SQL_OPERATOR_TYPE_", has_type_id = false)]
    public enum SqlOperatorType {
        AND,
        OR,
        EQ,
        IS,
        LIKE,
        BETWEEN,
        GT,
        LT,
        GEQ,
        LEQ,
        DIFF,
        REGEXP,
        REGEXP_CI,
        NOT_REGEXP,
        NOT_REGEXP_CI,
        SIMILAR,
        ISNULL,
        ISNOTNULL,
        NOT,
        IN,
        NOTIN,
        CONCAT,
        PLUS,
        MINUS,
        STAR,
        DIV,
        REM,
        BITAND,
        BITOR,
        BITNOT,
        ILIKE,
        NOTLIKE,
        NOTILIKE,
        GLOB
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SQL_PARSER_", has_type_id = false)]
    public enum SqlParserError {
        SYNTAX_ERROR,
        OVERFLOW_ERROR,
        EMPTY_SQL_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SQL_PARSER_FLAVOUR_", has_type_id = false)]
    public enum SqlParserFlavour {
        STANDARD,
        SQLITE,
        MYSQL,
        ORACLE,
        POSTGRESQL
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SQL_PARSER_MODE_", has_type_id = false)]
    public enum SqlParserMode {
        PARSE,
        DELIMIT
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SQL_SELECT_JOIN_", has_type_id = false)]
    public enum SqlSelectJoinType {
        CROSS,
        NATURAL,
        INNER,
        LEFT,
        RIGHT,
        FULL;
        public unowned string to_string ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SQL_STATEMENT_COMPOUND_", has_type_id = false)]
    public enum SqlStatementCompoundType {
        UNION,
        UNION_ALL,
        INTERSECT,
        INTERSECT_ALL,
        EXCEPT,
        EXCEPT_ALL
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SQL_STATEMENT_", has_type_id = false)]
    public enum SqlStatementType {
        SELECT,
        INSERT,
        UPDATE,
        DELETE,
        COMPOUND,
        BEGIN,
        ROLLBACK,
        COMMIT,
        SAVEPOINT,
        ROLLBACK_SAVEPOINT,
        DELETE_SAVEPOINT,
        UNKNOWN,
        NONE
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_STATEMENT_", has_type_id = false)]
    public enum StatementError {
        PARSE_ERROR,
        SYNTAX_ERROR,
        NO_CNC_ERROR,
        CNC_CLOSED_ERROR,
        EXEC_ERROR,
        PARAM_TYPE_ERROR,
        PARAM_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_STATEMENT_MODEL_", has_type_id = false)]
    [Flags]
    public enum StatementModelUsage {
        RANDOM_ACCESS,
        CURSOR_FORWARD,
        CURSOR_BACKWARD,
        CURSOR,
        ALLOW_NOPARAM,
        OFFLINE
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_STATEMENT_SQL_", has_type_id = false)]
    [Flags]
    public enum StatementSqlFlag {
        PARAMS_AS_VALUES,
        PRETTY,
        PARAMS_LONG,
        PARAMS_SHORT,
        PARAMS_AS_COLON,
        PARAMS_AS_DOLLAR,
        PARAMS_AS_QMARK,
        PARAMS_AS_UQMARK,
        TIMEZONE_TO_GMT
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_THREAD_NOTIFICATION_", has_type_id = false)]
    public enum ThreadNotificationType {
        JOB,
        SIGNAL
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_THREAD_WRAPPER_UNKNOWN_", has_type_id = false)]
    public enum ThreadWrapperError {
        [CCode (cname = "GDA_THREAD_WRAPPER_UNKNOWN_ERROR")]
        THREAD_WRAPPER_UNKNOWN_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_TRANSACTION_ISOLATION_", has_type_id = false)]
    public enum TransactionIsolation {
        UNKNOWN,
        READ_COMMITTED,
        READ_UNCOMMITTED,
        REPEATABLE_READ,
        SERIALIZABLE
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_TRANSACTION_STATUS_EVENT_", has_type_id = false)]
    public enum TransactionStatusEventType {
        SAVEPOINT,
        SQL,
        SUB_TRANSACTION
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_TRANSACTION_STATUS_STATE_", has_type_id = false)]
    public enum TransactionStatusState {
        OK,
        FAILED
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_TREE_UNKNOWN_", has_type_id = false)]
    public enum TreeError {
        [CCode (cname = "GDA_TREE_UNKNOWN_ERROR")]
        TREE_UNKNOWN_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_TREE_MANAGER_UNKNOWN_", has_type_id = false)]
    public enum TreeManagerError {
        [CCode (cname = "GDA_TREE_MANAGER_UNKNOWN_ERROR")]
        TREE_MANAGER_UNKNOWN_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_TREE_NODE_UNKNOWN_", has_type_id = false)]
    public enum TreeNodeError {
        [CCode (cname = "GDA_TREE_NODE_UNKNOWN_ERROR")]
        TREE_NODE_UNKNOWN_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_VALUE_ATTR_", has_type_id = false)]
    [Flags]
    public enum ValueAttribute {
        NONE,
        IS_NULL,
        CAN_BE_NULL,
        IS_DEFAULT,
        CAN_BE_DEFAULT,
        IS_UNCHANGED,
        ACTIONS_SHOWN,
        DATA_NON_VALID,
        HAS_VALUE_ORIG,
        NO_MODIF,
        UNUSED
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_XA_TRANSACTION_", has_type_id = false)]
    public enum XaTransactionError {
        ALREADY_REGISTERED_ERROR,
        DTP_NOT_SUPPORTED_ERROR,
        CONNECTION_BRANCH_LENGTH_ERROR
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_DATA_MODEL_")]
    public errordomain DataModelError {
        ROW_OUT_OF_RANGE_ERROR,
        COLUMN_OUT_OF_RANGE_ERROR,
        VALUES_LIST_ERROR,
        VALUE_TYPE_ERROR,
        ROW_NOT_FOUND_ERROR,
        ACCESS_ERROR,
        FEATURE_NON_SUPPORTED_ERROR,
        FILE_EXIST_ERROR,
        XML_FORMAT_ERROR,
        TRUNCATED_ERROR,
        OTHER_ERROR;
        public static GLib.Quark quark ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", cprefix = "GDA_SQL_")]
    public errordomain SqlError {
        STRUCTURE_CONTENTS_ERROR,
        MALFORMED_IDENTIFIER_ERROR,
        MISSING_IDENTIFIER_ERROR,
        VALIDATION_ERROR;
        public static GLib.Quark quark ();
    }
    [CCode (cheader_filename = "libgda/libgda.h", has_target = false)]
    public delegate void AttributesManagerFunc (string att_name, GLib.Value value, void* data);
    [CCode (cheader_filename = "libgda/libgda.h", has_target = false)]
    public delegate void AttributesManagerSignal (GLib.Object obj, string att_name, GLib.Value value, void* data);
    [CCode (cheader_filename = "libgda/libgda.h", has_target = false)]
    public delegate void ServerProviderAsyncCallback (Gda.ServerProvider provider, Gda.Connection cnc, uint task_id, bool result_status, GLib.Error error, void* data);
    [CCode (cheader_filename = "libgda/libgda.h", has_target = false)]
    public delegate void ServerProviderExecCallback (Gda.ServerProvider provider, Gda.Connection cnc, uint task_id, GLib.Object result_obj, GLib.Error error, void* data);
    [CCode (cheader_filename = "libgda/libgda.h", has_target = false)]
    public delegate string SqlRenderingValue (GLib.Value value, Gda.SqlRenderingContext context) throws GLib.Error;
    [CCode (cheader_filename = "libgda/libgda.h", has_target = false)]
    public delegate bool SqlReservedKeywordsFunc (string word);
    [CCode (cheader_filename = "libgda/libgda.h", has_target = false)]
    public delegate void ThreadWrapperCallback (Gda.ThreadWrapper wrapper, void* instance, string signame, int n_param_values, GLib.Value param_values, void* gda_reserved, void* data);
    [CCode (cheader_filename = "libgda/libgda.h", has_target = false)]
    public delegate void* ThreadWrapperFunc (void* arg) throws GLib.Error;
    [CCode (cheader_filename = "libgda/libgda.h", has_target = false)]
    public delegate void ThreadWrapperVoidFunc (void* arg) throws GLib.Error;
    [CCode (cheader_filename = "libgda/libgda.h", cname = "GDA_ATTRIBUTE_AUTO_INCREMENT")]
    public const string ATTRIBUTE_AUTO_INCREMENT;
    [CCode (cheader_filename = "libgda/libgda.h", cname = "GDA_ATTRIBUTE_DESCRIPTION")]
    public const string ATTRIBUTE_DESCRIPTION;
    [CCode (cheader_filename = "libgda/libgda.h", cname = "GDA_ATTRIBUTE_IS_DEFAULT")]
    public const string ATTRIBUTE_IS_DEFAULT;
    [CCode (cheader_filename = "libgda/libgda.h", cname = "GDA_ATTRIBUTE_NAME")]
    public const string ATTRIBUTE_NAME;
    [CCode (cheader_filename = "libgda/libgda.h", cname = "GDA_ATTRIBUTE_NUMERIC_PRECISION")]
    public const string ATTRIBUTE_NUMERIC_PRECISION;
    [CCode (cheader_filename = "libgda/libgda.h", cname = "GDA_ATTRIBUTE_NUMERIC_SCALE")]
    public const string ATTRIBUTE_NUMERIC_SCALE;
    [CCode (cheader_filename = "libgda/libgda.h", cname = "GDA_ATTRIBUTE_TREE_NODE_UNKNOWN_CHILDREN")]
    public const string ATTRIBUTE_TREE_NODE_UNKNOWN_CHILDREN;
    [CCode (cheader_filename = "libgda/libgda.h", cname = "GDA_EXTRA_AUTO_INCREMENT")]
    public const string EXTRA_AUTO_INCREMENT;
    [CCode (cheader_filename = "libgda/libgda.h", cname = "GDA_SQLSTATE_GENERAL_ERROR")]
    public const string SQLSTATE_GENERAL_ERROR;
    [CCode (cheader_filename = "libgda/libgda.h", cname = "GDA_SQLSTATE_NO_ERROR")]
    public const string SQLSTATE_NO_ERROR;
    [CCode (cheader_filename = "libgda/libgda.h", cname = "GDA_TIMEZONE_INVALID")]
    public const int TIMEZONE_INVALID;
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static string alphanum_to_text (string text);
    [CCode (array_length = false, array_null_terminated = true, cheader_filename = "libgda/libgda.h")]
    public static string[]? completion_list_get (Gda.Connection cnc, string sql, int start, int end);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static bool compute_dml_statements (Gda.Connection cnc, Gda.Statement select_stmt, bool require_pk, owned Gda.Statement? insert_stmt, owned Gda.Statement? update_stmt, owned Gda.Statement? delete_stmt) throws GLib.Error;
    [CCode (cheader_filename = "libgda/libgda.h")]
    [Version (since = "4.2.3")]
    public static unowned Gda.DataHandler data_handler_get_default (GLib.Type for_type);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static void dsn_split (string string, string out_dsn, string out_username, string out_password);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static GLib.Type g_type_from_string (string str);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static unowned string g_type_to_string (GLib.Type type);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static string get_application_exec_path (string app_name);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static bool identifier_equal (string id1, string id2);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static uint identifier_hash (string id);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static void init ();
    [CCode (cheader_filename = "libgda/libgda.h")]
    [Version (since = "4.2.3")]
    public static void locale_changed ();
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static void log_disable ();
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static void log_enable ();
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static bool log_is_enabled ();
    [CCode (cheader_filename = "libgda/libgda.h")]
    [Version (since = "5.2")]
    public static bool parse_formatted_date (GLib.Date gdate, string value, GLib.DateDMY first, GLib.DateDMY second, GLib.DateDMY third, char sep);
    [CCode (cheader_filename = "libgda/libgda.h")]
    [Version (since = "5.2")]
    public static bool parse_formatted_time (Gda.Time timegda, string value, char sep);
    [CCode (cheader_filename = "libgda/libgda.h")]
    [Version (since = "5.2")]
    public static bool parse_formatted_timestamp (Gda.Timestamp timestamp, string value, GLib.DateDMY first, GLib.DateDMY second, GLib.DateDMY third, char sep);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static bool parse_iso8601_date (GLib.Date gdate, string value);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static bool parse_iso8601_time (Gda.Time timegda, string value);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static bool parse_iso8601_timestamp (Gda.Timestamp timestamp, string value);
    [CCode (cheader_filename = "libgda/libgda.h")]
    [Version (since = "4.2.9")]
    public static bool rewrite_statement_for_null_parameters (Gda.Statement stmt, Gda.Set @params, owned Gda.Statement? out_stmt) throws GLib.Error;
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static bool rfc1738_decode (string string);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static string rfc1738_encode (string string);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static Gda.Statement select_alter_select_for_empty (Gda.Statement stmt) throws GLib.Error;
    [CCode (cheader_filename = "libgda/libgda.h")]
    [Version (since = "4.0.3")]
    public static string sql_identifier_quote (string id, Gda.Connection? cnc, Gda.ServerProvider? prov, bool meta_store_convention, bool force_quotes);
    [CCode (array_length = false, array_null_terminated = true, cheader_filename = "libgda/libgda.h")]
    public static string[]? sql_identifier_split (string id);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static Gda.SqlOperatorType sql_operation_operator_from_string (string op);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static unowned string sql_operation_operator_to_string (Gda.SqlOperatorType op);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static Gda.Binary string_to_binary (string? str);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static Gda.Blob string_to_blob (string str);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static string text_to_alphanum (string text);
    [CCode (cheader_filename = "libgda/libgda.h")]
    [Version (since = "4.2.6")]
    public static bool utility_check_data_model_v (Gda.DataModel model, [CCode (array_length_cname = "nbcols", array_length_pos = 1.5)] GLib.Type[] types);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static bool utility_data_model_dump_data_to_xml (Gda.DataModel model, [CCode (type = "xmlNodePtr")] Xml.Node* parent, [CCode (array_length_cname = "nb_cols", array_length_pos = 3.5)] int[]? cols, [CCode (array_length_cname = "nb_rows", array_length_pos = 4.5)] int[]? rows, bool use_col_ids);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static unowned string utility_data_model_find_column_description (Gda.DataSelect model, string field_name);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static bool utility_holder_load_attributes (Gda.Holder holder, [CCode (type = "xmlNodePtr")] Xml.Node* node, GLib.SList<Gda.DataModel> sources) throws GLib.Error;
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static int value_compare (GLib.Value value1, GLib.Value value2);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static int value_differ (GLib.Value value1, GLib.Value value2);
    [CCode (cheader_filename = "libgda/libgda.h")]
    public static string value_stringify (GLib.Value value);
}
