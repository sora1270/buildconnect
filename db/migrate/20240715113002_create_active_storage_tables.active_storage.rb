class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    create_table :active_storage_blobs do |t|
      t.string   :key, null: false
      t.string   :filename, null: false
      t.string   :content_type
      t.text     :metadata
      t.string   :service_name, null: false
      t.bigint   :byte_size, null: false
      t.string   :checksum, null: false
      t.datetime :created_at, null: false

      t.index [:key], unique: true
    end

    create_table :active_storage_attachments do |t|
      t.string     :name, null: false
      t.references :record, polymorphic: true, null: false
      t.references :blob, null: false

      t.datetime :created_at, null: false

      t.index [:record_type, :record_id, :name, :blob_id], unique: true, name: 'index_active_storage_attachments_uniqueness'
      t.foreign_key :active_storage_blobs, column: :blob_id
    end

    create_table :active_storage_variant_records do |t|
      t.belongs_to :blob, null: false
      t.string :variation_digest, null: false

      t.index [:blob_id, :variation_digest], unique: true, name: 'index_active_storage_variant_records_uniqueness'
      t.foreign_key :active_storage_blobs, column: :blob_id
    end
  end
end
