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

JS

```
//= require jquery
//= require jquery-ui
//= require jquery_ujs

// OPTIONALLY
//= require turbolinks

//= require log_js

//= require the_storages/jQuery-File-Upload/jquery.iframe-transport
//= require the_storages/jQuery-File-Upload/jquery.fileupload
//= require the_sortable_tree/jquery.ui.nestedSortable

//= require the_storages/file_uploader
//= require the_storages/sortable

// without turbolinks
$ ->
  TheStorgesSortable.init()
  TheStoragesFileUploader.init()

// with turbolinks
$(document).on "ready page:load", ->
  TheStorgesSortable.init()
  TheStoragesFileUploader.init()
```

CSS

```
link(href='//maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css'   rel='stylesheet' type='text/css')
```

```
#= require the_storages/styles
#= require the_storages/file_types
```

VIEW

```
.w800.mt20.mb20.ptz_theme-0
  .mb20= render partial: 'the_storages/form', locals: { storage: @pub }
  = render partial: 'the_storages/list', locals: { storage: @pub }
```
