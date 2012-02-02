# Generation X

Some vim commands to generate various types of file and create the
typical directory structure.

Really, this is just an excuse to play around with vimscript and doesn't consist
of much.

## Installation

Install [pathogen](ihttps://github.com/tpope/vim-pathogen)

    cd ~/.vim/bundle
    git https://github.com/markryall/generation_x

## Ruby

### RubyClass

    :RubyClass aardvark_ocelot dog_cat flyweight_helper_builder_factory

This will create the following directory structure:

    .
    ├── lib
    │   └── aardvark_ocelot
    │       └── dog_cat
    │           └── flyweight_helper_build_factory.rb
    └── spec
        └── aardvark_ocelot
            └── dog_cat
                └── flyweight_helper_build_factory_spec.rb

You will find yourself defining the behaviour of the
AardvarkOcelot::DogCat::FlyweightHelperBuildFactory class in a spec.

Both files will be opened in different buffers and put the cursor in position
for you to start writing your spec.

### RubyModule

Does exactly the same thing but generates a module.
