require 'sslyze/task'

require 'rprogram/program'

module SSLyze
  #
  # Represents the `sslyze` command line utility.
  #
  class Program < RProgram::Program

    name_program 'sslyze'

    #
    # Finds the `sslyze` script and runs it.
    #
    # @param [Hash{Symbol => Object}] options
    #   Additional options for `sslyze`.
    #
    # @param [Hash{Symbol => Object}] exec_options
    #   Additional exec-options.
    #
    # @yield [task]
    #   If a block is given, it will be passed a task object
    #   used to specify options for `sslyze`.
    #
    # @yieldparam [Task] task
    #   The sslyze task object.
    #
    # @return [Boolean]
    #   Specifies whether the command exited normally.
    #
    # @see http://rubydoc.info/gems/rprogram/0.3.0/RProgram/Program#run-instance_method
    #   For additional exec-options.
    #
    def self.analyze(options={},exec_options={},&block)
      find.analyze(options,exec_options,&block)
    end

    #
    # Runs `sslyze`.
    #
    # @param [Hash{Symbol => Object}] options
    #   Additional options for `sslyze`.
    #
    # @param [Hash{Symbol => Object}] exec_options
    #   Additional exec-options.
    #
    # @yield [task]
    #   If a block is given, it will be passed a task object
    #   used to specify options for `sslyze`.
    #
    # @yieldparam [Task] task
    #   The sslyze task object.
    #
    # @return [Boolean]
    #   Specifies whether the command exited normally.
    #
    # @see http://rubydoc.info/gems/rprogram/0.3.0/RProgram/Program#run-instance_method
    #   For additional exec-options.
    #
    def analyze(options={},exec_options={},&block)
      run_task(Task.new(options,&block),exec_options)
    end

  end
end
