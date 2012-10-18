module DNSimple
  module Commands
    class MembershipList
      def execute(args, options={})
        domain_name = args.shift
        memberships = Membership.list_membership(domain_name)
        memberships.each do |membership|
          puts "\tUser ID: #{membership.user_id}\tPermissions: #{membership.permission}\tDomain: #{domain_name} "
        end
      end
    end
  end
end
