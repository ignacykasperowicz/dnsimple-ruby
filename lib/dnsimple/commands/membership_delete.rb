module DNSimple
  module Commands
    class MembershipDelete
      def execute(args, options={})
        domain_name = args.shift
        domain = Domain.find(domain_name)
        email = args.shift
        domain.delete_membership(email)
        puts "Deleted #{email} from #{domain_name}"
      end
    end
  end
end
