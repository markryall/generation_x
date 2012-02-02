# Generation X

Some vim commands to generate various types of file and create the
typical directory structure.

Really, this is just an excuse to play around with vimscript and doesn't consist
of much.

## Installation

Install [pathogen](ihttps://github.com/tpope/vim-pathogen)

    cd ~/.vim/bundle
    git https://github.com/markryall/generation_x

## Usage

### RubyClass

    :RubyClass aardvark_ocelot dog_cat flyweight_helper_builder_factory

This will create the following directory structure:

    .
    ├── lib
    │   └── aardvark_ocelot
    │       └── dog_cat
    │           └── flyweight_helper_builder_factory.rb
    └── spec
        └── aardvark_ocelot
            └── dog_cat
                └── flyweight_helper_builder_factory_spec.rb

You will find yourself defining the behaviour of the
AardvarkOcelot::DogCat::FlyweightHelperBuilderFactory class in a spec.

Both files will be opened in different buffers and the cursor will be in position
for you to start writing your first spec.

### RubyModule

    :RubyModule aardvark_ocelot dog_cat adapter_bridge_interpreter_singleton

Does exactly the same thing as for RubyClass but generates a module.

## Development

The testing uses rspec.  The testing of vim is performed by sending key strokes
to a tmux session.  You'll need one console for tmux and another for running
the specs.

Console 1

    tmux

Console 2

    bundle
    rake
