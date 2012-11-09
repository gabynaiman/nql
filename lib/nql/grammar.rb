# Autogenerated from a Treetop grammar. Edits may be lost.


module NQL
  module Syntax
    include Treetop::Runtime

    def root
      @root ||= :expression
    end

    def _nt_expression
      start_index = index
      if node_cache[:expression].has_key?(index)
        cached = node_cache[:expression][index]
        if cached
          cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
          @index = cached.interval.end
        end
        return cached
      end

      i0 = index
      r1 = _nt_boolean
      if r1
        r0 = r1
      else
        r2 = _nt_primary
        if r2
          r0 = r2
        else
          @index = i0
          r0 = nil
        end
      end

      node_cache[:expression][start_index] = r0

      r0
    end

    module Boolean0
      def left
        elements[0]
      end

      def space1
        elements[1]
      end

      def coordinator
        elements[2]
      end

      def space2
        elements[3]
      end

      def right
        elements[4]
      end
    end

    module Boolean1
      def to_ransack
        group = {g: [{m: coordinator.to_ransack}]}

        [left, right].each do |side|
          if side.is_node?(:boolean)
            group[:g][0].merge! side.to_ransack
          else
            group[:g][0][:c] ||= []
            group[:g][0][:c] << side.to_ransack
          end
        end

        group
      end

      def is_node?(node_type)
        node_type.to_sym == :boolean
      end
    end

    def _nt_boolean
      start_index = index
      if node_cache[:boolean].has_key?(index)
        cached = node_cache[:boolean][index]
        if cached
          cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
          @index = cached.interval.end
        end
        return cached
      end

      i0, s0 = index, []
      r1 = _nt_primary
      s0 << r1
      if r1
        r2 = _nt_space
        s0 << r2
        if r2
          r3 = _nt_coordinator
          s0 << r3
          if r3
            r4 = _nt_space
            s0 << r4
            if r4
              r5 = _nt_expression
              s0 << r5
            end
          end
        end
      end
      if s0.last
        r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
        r0.extend(Boolean0)
        r0.extend(Boolean1)
      else
        @index = i0
        r0 = nil
      end

      node_cache[:boolean][start_index] = r0

      r0
    end

    module Primary0
      def space1
        elements[0]
      end

      def comparison
        elements[1]
      end

      def space2
        elements[2]
      end
    end

    module Primary1
      def space1
        elements[1]
      end

      def expression
        elements[2]
      end

      def space2
        elements[3]
      end

    end

    module Primary2
      def to_ransack
        detect_node.to_ransack
      end

      def detect_node
        self.send %w(comparison expression).detect { |m| self.respond_to? m }
      end

      def is_node?(node_type)
        detect_node.is_node?(node_type)
      end
    end

    def _nt_primary
      start_index = index
      if node_cache[:primary].has_key?(index)
        cached = node_cache[:primary][index]
        if cached
          cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
          @index = cached.interval.end
        end
        return cached
      end

      i0 = index
      i1, s1 = index, []
      r2 = _nt_space
      s1 << r2
      if r2
        r3 = _nt_comparison
        s1 << r3
        if r3
          r4 = _nt_space
          s1 << r4
        end
      end
      if s1.last
        r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
        r1.extend(Primary0)
      else
        @index = i1
        r1 = nil
      end
      if r1
        r0 = r1
        r0.extend(Primary2)
      else
        i5, s5 = index, []
        if has_terminal?('(', false, index)
          r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('(')
          r6 = nil
        end
        s5 << r6
        if r6
          r7 = _nt_space
          s5 << r7
          if r7
            r8 = _nt_expression
            s5 << r8
            if r8
              r9 = _nt_space
              s5 << r9
              if r9
                if has_terminal?(')', false, index)
                  r10 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure(')')
                  r10 = nil
                end
                s5 << r10
              end
            end
          end
        end
        if s5.last
          r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
          r5.extend(Primary1)
        else
          @index = i5
          r5 = nil
        end
        if r5
          r0 = r5
          r0.extend(Primary2)
        else
          @index = i0
          r0 = nil
        end
      end

      node_cache[:primary][start_index] = r0

      r0
    end

    module Coordinator0
      def to_ransack
        coordinators = {'|' => 'or', '&' => 'and'}
        coordinators[text_value]
      end
    end

    def _nt_coordinator
      start_index = index
      if node_cache[:coordinator].has_key?(index)
        cached = node_cache[:coordinator][index]
        if cached
          cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
          @index = cached.interval.end
        end
        return cached
      end

      i0 = index
      if has_terminal?('|', false, index)
        r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure('|')
        r1 = nil
      end
      if r1
        r0 = r1
        r0.extend(Coordinator0)
      else
        if has_terminal?('&', false, index)
          r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('&')
          r2 = nil
        end
        if r2
          r0 = r2
          r0.extend(Coordinator0)
        else
          @index = i0
          r0 = nil
        end
      end

      node_cache[:coordinator][start_index] = r0

      r0
    end

    module Comparison0
      def variable
        elements[0]
      end

      def space1
        elements[1]
      end

      def comparator
        elements[2]
      end

      def space2
        elements[3]
      end

      def value
        elements[4]
      end
    end

    module Comparison1
      def to_ransack
        hash = {a: {'0' => {name: self.variable.text_value.gsub('.', '_')}}, p: self.comparator.to_ransack, v: {'0' => {value: self.value.text_value}}}
        hash = {c: [hash]} if !parent || !parent.parent || text_value == parent.parent.text_value
        hash
      end

      def is_node?(node_type)
        node_type.to_sym == :comparison
      end
    end

    def _nt_comparison
      start_index = index
      if node_cache[:comparison].has_key?(index)
        cached = node_cache[:comparison][index]
        if cached
          cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
          @index = cached.interval.end
        end
        return cached
      end

      i0, s0 = index, []
      r1 = _nt_alphanumeric
      s0 << r1
      if r1
        r2 = _nt_space
        s0 << r2
        if r2
          r3 = _nt_comparator
          s0 << r3
          if r3
            r4 = _nt_space
            s0 << r4
            if r4
              r5 = _nt_text
              s0 << r5
            end
          end
        end
      end
      if s0.last
        r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
        r0.extend(Comparison0)
        r0.extend(Comparison1)
      else
        @index = i0
        r0 = nil
      end

      node_cache[:comparison][start_index] = r0

      r0
    end

    module Comparator0
      def to_ransack
        comparators = {
          '=' => 'eq',
          '!=' => 'not_eq',
          '>' => 'gt',
          '>=' => 'gteq',
          '<' => 'lt',
          '<=' => 'lteq',
          '%' => 'cont'
        }
        comparators[text_value]
      end
    end

    def _nt_comparator
      start_index = index
      if node_cache[:comparator].has_key?(index)
        cached = node_cache[:comparator][index]
        if cached
          cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
          @index = cached.interval.end
        end
        return cached
      end

      s0, i0 = [], index
      loop do
        i1 = index
        if has_terminal?('=', false, index)
          r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('=')
          r2 = nil
        end
        if r2
          r1 = r2
        else
          if has_terminal?('!=', false, index)
            r3 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure('!=')
            r3 = nil
          end
          if r3
            r1 = r3
          else
            if has_terminal?('>', false, index)
              r4 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure('>')
              r4 = nil
            end
            if r4
              r1 = r4
            else
              if has_terminal?('>=', false, index)
                r5 = instantiate_node(SyntaxNode,input, index...(index + 2))
                @index += 2
              else
                terminal_parse_failure('>=')
                r5 = nil
              end
              if r5
                r1 = r5
              else
                if has_terminal?('<', false, index)
                  r6 = instantiate_node(SyntaxNode,input, index...(index + 1))
                  @index += 1
                else
                  terminal_parse_failure('<')
                  r6 = nil
                end
                if r6
                  r1 = r6
                else
                  if has_terminal?('<=', false, index)
                    r7 = instantiate_node(SyntaxNode,input, index...(index + 2))
                    @index += 2
                  else
                    terminal_parse_failure('<=')
                    r7 = nil
                  end
                  if r7
                    r1 = r7
                  else
                    if has_terminal?('%', false, index)
                      r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
                      @index += 1
                    else
                      terminal_parse_failure('%')
                      r8 = nil
                    end
                    if r8
                      r1 = r8
                    else
                      @index = i1
                      r1 = nil
                    end
                  end
                end
              end
            end
          end
        end
        if r1
          s0 << r1
        else
          break
        end
      end
      if s0.empty?
        @index = i0
        r0 = nil
      else
        r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
        r0.extend(Comparator0)
      end

      node_cache[:comparator][start_index] = r0

      r0
    end

    module Text0
      def space
        elements[0]
      end

    end

    module Text1
    end

    def _nt_text
      start_index = index
      if node_cache[:text].has_key?(index)
        cached = node_cache[:text][index]
        if cached
          cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
          @index = cached.interval.end
        end
        return cached
      end

      i0, s0 = index, []
      s1, i1 = [], index
      loop do
        i2 = index
        r3 = _nt_alphanumeric
        if r3
          r2 = r3
        else
          r4 = _nt_utf8
          if r4
            r2 = r4
          else
            r5 = _nt_symbol
            if r5
              r2 = r5
            else
              @index = i2
              r2 = nil
            end
          end
        end
        if r2
          s1 << r2
        else
          break
        end
      end
      if s1.empty?
        @index = i1
        r1 = nil
      else
        r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      end
      s0 << r1
      if r1
        s6, i6 = [], index
        loop do
          i7, s7 = index, []
          r8 = _nt_space
          s7 << r8
          if r8
            s9, i9 = [], index
            loop do
              i10 = index
              r11 = _nt_alphanumeric
              if r11
                r10 = r11
              else
                r12 = _nt_utf8
                if r12
                  r10 = r12
                else
                  r13 = _nt_symbol
                  if r13
                    r10 = r13
                  else
                    @index = i10
                    r10 = nil
                  end
                end
              end
              if r10
                s9 << r10
              else
                break
              end
            end
            if s9.empty?
              @index = i9
              r9 = nil
            else
              r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
            end
            s7 << r9
          end
          if s7.last
            r7 = instantiate_node(SyntaxNode,input, i7...index, s7)
            r7.extend(Text0)
          else
            @index = i7
            r7 = nil
          end
          if r7
            s6 << r7
          else
            break
          end
        end
        r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
        s0 << r6
      end
      if s0.last
        r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
        r0.extend(Text1)
      else
        @index = i0
        r0 = nil
      end

      node_cache[:text][start_index] = r0

      r0
    end

    def _nt_alphanumeric
      start_index = index
      if node_cache[:alphanumeric].has_key?(index)
        cached = node_cache[:alphanumeric][index]
        if cached
          cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
          @index = cached.interval.end
        end
        return cached
      end

      s0, i0 = [], index
      loop do
        if has_terminal?('\G[a-zA-Z0-9_.]', true, index)
          r1 = true
          @index += 1
        else
          r1 = nil
        end
        if r1
          s0 << r1
        else
          break
        end
      end
      if s0.empty?
        @index = i0
        r0 = nil
      else
        r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      end

      node_cache[:alphanumeric][start_index] = r0

      r0
    end

    def _nt_space
      start_index = index
      if node_cache[:space].has_key?(index)
        cached = node_cache[:space][index]
        if cached
          cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
          @index = cached.interval.end
        end
        return cached
      end

      s0, i0 = [], index
      loop do
        if has_terminal?(' ', false, index)
          r1 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure(' ')
          r1 = nil
        end
        if r1
          s0 << r1
        else
          break
        end
      end
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)

      node_cache[:space][start_index] = r0

      r0
    end

    def _nt_symbol
      start_index = index
      if node_cache[:symbol].has_key?(index)
        cached = node_cache[:symbol][index]
        if cached
          cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
          @index = cached.interval.end
        end
        return cached
      end

      if has_terminal?('\G[><=+-\\/\\\\@#$%!?:]', true, index)
        r0 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r0 = nil
      end

      node_cache[:symbol][start_index] = r0

      r0
    end

    def _nt_utf8
      start_index = index
      if node_cache[:utf8].has_key?(index)
        cached = node_cache[:utf8][index]
        if cached
          cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
          @index = cached.interval.end
        end
        return cached
      end

      if has_terminal?('\G[\\u00c1\\u00c0\\u00c9\\u00c8\\u00cd\\u00cc\\u00d3\\u00d2\\u00da\\u00d9\\u00dc\\u00d1\\u00c7\\u00e1\\u00e0\\u00e9\\u00e8\\u00ed\\u00ec\\u00f3\\u00f2\\u00fa\\u00f9\\u00fc\\u00f1\\u00e7]', true, index)
        r0 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        r0 = nil
      end

      node_cache[:utf8][start_index] = r0

      r0
    end

  end

  class SyntaxParser < Treetop::Runtime::CompiledParser
    include Syntax
  end

end