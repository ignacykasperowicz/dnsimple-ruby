module DNSimple
  module Commands
    class MembershipAdd
      def execute(args, options={})
        domain_name = args.shift
        domain = Domain.find(domain_name)
        email = args.shift
        domain.add_membership(email)
        puts"Added #{email} to #{domain_name}"
      end
    end
  end
end
