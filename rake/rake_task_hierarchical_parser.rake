#
# Rake task hierarchical parser
#
# Install:
#   put this file on ${HOME}/.rake directory
#
# Usage:
#   rake -g dependency
#   rake -g 'dependency[task_name]'
#
# Example:
#   $ rake -g 'dependency[spec]'
#     spec
#       db:test:prepare
#           db:abort_if_pending_migrations
#                 environment
#

import File.join(Dir.pwd, 'Rakefile')

class Object
  def returning(value)
    yield(value)
    value
  end unless Object.new.respond_to?(:returning)
end

module Enumerable
  def each_with_object(memo, &block)
    returning memo do |m|
      each do |element|
        block.call(element, m)
      end
    end
  end unless [].respond_to?(:each_with_object)
end

class RakeTaskHierarchicalParser

  def self.parse(tasks, target_task_name = nil)
    new(tasks, target_task_name).run
  end

  def run
    if @target_task_name && !@target_task_name.empty?
      if @tree[@target_task_name]
        put_dependency_task(@target_task_name)
      else
        puts "#{@target_task_name} is undefined!"
      end
    else
      @tree.sort.each do |task_name, preqs|
        put_dependency_task(task_name)
      end
    end
  end

  private

  def initialize(tasks, target_task_name)
    @tree = tasks.each_with_object({}) do |t, result|
      next unless t.instance_of?(Rake::Task)
      result[t.name] = t.prerequisites
    end
    @target_task_name = target_task_name
  end

  def put_dependency_task(targets, indent_level = 0)
    targets = [ targets ] unless targets.is_a?(Array)
    targets.each do |target|
      puts format(target, indent_level)
      if @tree[target] && !@tree[target].empty?
        put_dependency_task(@tree[target], indent_level + 1)
      end
    end
  end

  def format(task_name, indent_level)
    "#{ " " * ( indent_level * 2 ) }#{task_name}"
  end
end

task :dependency, "target_task_name"
desc "Output tasks and hierarchical dependencies"
task :dependency do |x, args|
  if ( t = args.target_task_name )
    RakeTaskHierarchicalParser.parse(Rake::Task.tasks, t)
  else
    RakeTaskHierarchicalParser.parse(Rake::Task.tasks)
  end
end
