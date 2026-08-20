export type NavItem = {
  label: string;
  href: `#${string}`;
};

export const navItems: NavItem[] = [
  { label: 'Home', href: '#hero' },
  { label: 'About', href: '#about' },
  { label: 'Properties', href: '#portfolio' },
  { label: 'Proposals', href: '#proposals' },
  { label: 'Team', href: '#team' },
  { label: 'Contact', href: '#contact' }
];

export type Property = {
  title: string;
  category: 'cedars' | 'oak' | 'bishop' | 'west';
  image: `/assets/img/properties/${string}`;
  width: number;
  height: number;
  description: string;
};

export const properties: Property[] = [
  {
    title: 'Cedars',
    category: 'cedars',
    image: '/assets/img/properties/cedars.jpg',
    width: 800,
    height: 468,
    description: 'Lorem ipsum, dolor sit'
  },
  {
    title: 'Oak Lawn',
    category: 'oak',
    image: '/assets/img/properties/oak-lawn.jpg',
    width: 980,
    height: 735,
    description: 'Lorem ipsum, dolor sit'
  },
  {
    title: 'Bishop Arts District',
    category: 'bishop',
    image: '/assets/img/properties/bishop-arts-district.jpg',
    width: 1200,
    height: 600,
    description: 'Lorem ipsum, dolor sit'
  },
  {
    title: 'West Dallas',
    category: 'west',
    image: '/assets/img/properties/west-dallas.jpg',
    width: 1199,
    height: 740,
    description: 'Lorem ipsum, dolor sit'
  }
];

export type Proposal = {
  title: string;
  description: string;
};

export const proposals: Proposal[] = [
  {
    title: 'Joint Ventures',
    description:
      'Joint Venture in Real Estate, a partnership with split profits of 50 / 50 or any combination depending on the agreed upon relative contribution.'
  },
  {
    title: 'Equity Deployment',
    description:
      'Looking to deploy equity for transactions that are acquiring & adding value to existing properties and for the construction of future properties.'
  },
  {
    title: 'Commercial Assets',
    description:
      'Multifamily, office, retail, industrial, mixed use, we are able to look at any commercial asset type, as long as the strategy makes sense. This includes qualified joint venture rental real estate.'
  }
];

export type TeamMember = {
  name: string;
  role: string;
  image: `/assets/img/team/${string}`;
  description: string;
};

export const teamMembers: TeamMember[] = [
  {
    name: 'Carl Castillo',
    role: 'Founder / CEO',
    image: '/assets/img/team/team-1.jpg',
    description: 'Lorem ipsum'
  },
  {
    name: 'Roy Castillo',
    role: 'Partner',
    image: '/assets/img/team/team-2.jpg',
    description: 'Lorem ipsum'
  },
  {
    name: 'Scott Castillo',
    role: 'Partner',
    image: '/assets/img/team/team-3.jpg',
    description: 'Lorem ipsum'
  }
];
