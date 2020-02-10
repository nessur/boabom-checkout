require "administrate/base_dashboard"

class OrderDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo.with_options(searchable: true),
    id: Field::Number,
    paid: Field::Boolean,
    paid_at: Field::DateTime,
    payment_month: Field::Number,
    emailed: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    total_order: Field::Number.with_options(prefix: '$'),
    discounted_total_order: Field::Number.with_options(prefix: '$'),
    course_subscriptions: Field::HasMany,
    boabom_courses: Field::HasMany
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  id
  user
  payment_month
  total_order
  discounted_total_order
  paid
  paid_at
  boabom_courses
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  paid
  paid_at
  payment_month
  user
  total_order
  discounted_total_order
  boabom_courses
  course_subscriptions
  id
  emailed
  created_at
  updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  user
  course_subscriptions
  payment_month
  paid
  paid_at
  emailed
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how orders are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(order)
  #   "Order ##{order.id}"
  # end
end
