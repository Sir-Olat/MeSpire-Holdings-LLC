class AddAttachmentDocumentToForms < ActiveRecord::Migration[5.1]

  def up
    add_attachment :forms, :document
  end

  def down
    remove_attachment :forms, :document
  end

end
