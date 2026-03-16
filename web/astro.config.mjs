// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
	site: 'https://stigsb.github.io',
	base: '/matlab-course',
	integrations: [
		starlight({
			title: 'MATLAB for Computational Neuroscience',
			sidebar: [
				{
					label: 'Course Modules',
					items: [
						{ label: 'Module 1: First Steps', slug: '01-first-steps' },
						{ label: 'Module 2: Vectors and Plotting', slug: '02-vectors-and-plotting' },
						{ label: 'Module 3: Programming Tools', slug: '03-programming-tools' },
						{ label: 'Module 4: Math Foundations', slug: '04-math-foundations' },
						{ label: 'Module 5: Neural Coding', slug: '05-neural-coding' },
						{ label: 'Module 6: Information Theory', slug: '06-information-theory' },
						{ label: 'Module 7: Dimensionality Reduction', slug: '07-dimensionality-reduction' },
						{ label: 'Module 8: Attractor Networks', slug: '08-attractor-networks' },
					],
				},
				{
					label: 'Reference',
					autogenerate: { directory: 'reference' },
				},
			],
		}),
	],
});
