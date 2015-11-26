## TheStorages

```
rake the_storages_engine:install:migrations

rails g the_storages install
```

```ruby
class AttachedFile < ActiveRecord::Base
  include ::TheStorages::AttachedFile
  include ::TheStorages::Watermarks
end
```

```
class User < ActiveRecord::Base
  include ::TheStorages::Storage
  include ::TheStorages::HasAttachedFiles
end

class Post < ActiveRecord::Base
  include ::TheStorages::Storage
end
```

```
class AttachedFilesController < ApplicationController
  include ::TheStorages::Controller
end
```