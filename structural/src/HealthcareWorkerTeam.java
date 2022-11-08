import java.util.HashSet;
import java.util.Set;

public class HealthcareWorkerTeam implements HealthcareServiceable {
    private Set<HealthcareServiceable> members = new HashSet<HealthcareServiceable>();

    public void addMember(HealthcareServiceable healthcareServiceable) {
        members.add(healthcareServiceable);
    }

    public void removeMember(HealthcareServiceable healthcareServiceable) {
        members.remove(healthcareServiceable);
    }

    public void service() {
        for (HealthcareServiceable member : members) {
            member.service();
        }

    }

    public double getPrice() {
        return members.stream().mapToDouble(member -> member.getPrice()).sum();
    }
}
