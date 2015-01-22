class Tag < ActiveRecord::Base
  after_create :add_counter
  before_destroy { |t| VisitCounter.find_by(flag: VisitCounter.flags[:tag], key: t.id).destroy }

  before_create :add_uid

  validates :name, :lang, :flag, presence: true
  #validates :name, uniqueness: {scope: [:lang, :flag], case_sensitive: false}
  enum flag: {product: 1, document: 2}

  has_and_belongs_to_many :documents

  def add_counter
    VisitCounter.create flag: VisitCounter.flags[:tag], key: self.id
  end

  def tree_id
    "child-#{self.id}"
  end

  def self.get_root_tree(flag, locale)
    children = self.select(:id, :name).where(
        'lang = ? AND flag = ? AND parent_id IS NULL',
        locale, self.flags[flag]).order(id: :asc).map { |t| self._get_node_tree t }

    {
        id: "root-#{flag}",
        text: I18n.t("models.#{flag}"),
        type: 'folder',
        children: children,
        state: {opened: true},
        icon: 'glyphicon glyphicon-home'
    }
  end

  private
  def self._get_node_tree(tag)
    children = self.select(:id, :name).where(parent_id: tag.id).order(id: :asc).map { |t| self._get_node_tree t }
    {
        id: tag.tree_id,
        text: tag.name,
        type: 'folder',
        state: {opened: true},
        children: children,
        #icon: 'glyphicon glyphicon-folder-open'
    }
  end
  def add_uid
    self.uid = SecureRandom.uuid
  end
end
