ActiveSupport.on_load(:action_controller) do
  require 'active_model_serializers/register_jsonapi_renderer'
end

ActiveModelSerializers.config.key_transform = :unaltered

# https://github.com/rails-api/active_model_serializers/blob/v0.10.6/docs/integrations/ember-and-json-api.md
ActiveModelSerializers.config.adapter = :json_api
# ActiveModelSerializers.config.adapter = ActiveModelSerializers::Adapter::JsonApi